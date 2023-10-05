import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iwallet/app/common/application.dart';
import 'package:iwallet/app/modules/initial/views/initial_view.dart';

class LoginController extends GetxController {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  var userName = TextEditingController().obs;
  var password = TextEditingController().obs;

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

  Future googleAuthLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Application.saveKey('token', 'google_auth');
      Application.user = FirebaseAuth.instance.currentUser;
      Get.offAll(() => const InitialView());
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future facebookAuthLogin() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);  
      if (loginResult.accessToken != null) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);
        await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        Application.saveKey('token', 'facebook_auth');
        Application.user = FirebaseAuth.instance.currentUser;
        Get.offAll(() => const InitialView());
      }
    } on Exception catch (_) {}
  }
}
