import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:iwallet/app/common/application.dart';
import 'package:iwallet/app/modules/initial/controllers/initial_controller.dart';
import 'package:iwallet/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:iwallet/app/widgets/loading_dialog.dart';

class ProfileController extends GetxController {
  var isDarkMode = false.obs;
  final user = Application.user;
  @override
  void onInit() {
    isDarkMode.value = Application.getKey('is_darkmode') ?? false;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onLogOut() {
    cautionDialog(
      'Signing out from this device?\n\n Your data on this device will be deleted. but you can always get them back once you sign in again.',
      title: 'Notice',
      onCancel: () {
        Get.back();
      },
      onDismiss: () {
        Get.find<NavigationController>().onLogOut();
      },
    );
  }

  void onChangeModeTheme() {
    final initialController = Get.find<InitialController>();
    initialController.onChangeThemeMode(!isDarkMode.value);
    isDarkMode.value = Application.getKey('is_darkmode') ?? false;
  }
}
