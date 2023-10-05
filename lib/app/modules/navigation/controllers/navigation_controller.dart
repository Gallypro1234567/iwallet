import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iwallet/app/common/application.dart';
import 'package:iwallet/app/modules/initial/views/initial_view.dart';
import 'package:iwallet/app/routes/app_pages.dart';

class NavigationController extends GetxController {
  var selected = Routes.TRANSACTION.obs;
  @override
  void onInit() {
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

  void onLogOut() async {
    FirebaseAuth.instance.signOut();
    if (Application.token == 'google_auth') {
      GoogleSignIn().signOut();
    }
    if (Application.token == 'facebook_auth') {
      FacebookAuth.instance.logOut();
    }
    Application.saveKey('token', '');
    Get.offAll(() => const InitialView());
  }
}
