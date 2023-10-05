import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iwallet/app/common/application.dart';
import 'package:iwallet/app/theme/app_theme.dart';

enum AuthenticationState {
  initial,
  unauthenticated,
  authenticated,
  loading,
}

class InitialController extends GetxController {
  var state = AuthenticationState.initial.obs;
  var themeMode = ThemeMode.light.obs;
  //

  @override
  void onInit() {
    Application.initApp().then(
      (_) async {
        var isDarkMode = Application.getKey('is_darkmode') ?? false;
        onChangeThemeMode(isDarkMode);
        if (Application.isLogin) {
          state.value = AuthenticationState.authenticated;
        } else {
          state.value = AuthenticationState.unauthenticated;
        }
      },
    );
    super.onInit();
  }

  void onChangeThemeMode(bool isDarkMode) {
    if (isDarkMode) {
      themeMode.value = ThemeMode.dark;
      Get.changeTheme(AppTheme.darkTheme);
    } else {
      themeMode.value = ThemeMode.light;
      Get.changeTheme(AppTheme.lightTheme);
    }
    Application.saveKey('is_darkmode', isDarkMode);
  }
}
