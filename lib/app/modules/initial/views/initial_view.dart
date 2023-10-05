import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwallet/app/common/application.dart';
import 'package:iwallet/app/routes/app_pages.dart';
import 'package:iwallet/app/widgets/loading_dialog.dart';

import '../controllers/initial_controller.dart';

class InitialView extends StatefulWidget {
  const InitialView({Key? key}) : super(key: key);

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  final controller = InitialController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Application.initApp().then(
          (_) async {
            loading();
            if (Application.isLogin) {
              Application.user = FirebaseAuth.instance.currentUser;
              controller.state.value = AuthenticationState.authenticated;
            } else {
              controller.state.value = AuthenticationState.unauthenticated;
            }
            await Future.delayed(const Duration(milliseconds: 1000));
            Get.back();
            setState(() {
              if (controller.state.value ==
                  AuthenticationState.unauthenticated) {
                Get.offAllNamed(Routes.LOGIN);
              }
              if (controller.state.value == AuthenticationState.authenticated) {
                Get.offAllNamed(Routes.NAVIGATION);
              }
            });
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
