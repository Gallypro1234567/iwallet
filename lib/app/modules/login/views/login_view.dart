import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iwallet/app/widgets/app_button.dart';
import 'package:iwallet/app/widgets/app_input.dart';

import '../controllers/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
  final controller = LoginController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  'IWallet',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 42),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Continue to sign up for free',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: Text(
                  "If you already have an account, we'll log you in",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(height: 8.0),
              ...[
                {
                  'title': 'Continue with Apple',
                  'icon': SvgPicture.asset('assets/icons/apple.svg'),
                  'action': controller.googleAuthLogin,
                },
                {
                  'title': 'Continue with Google',
                  'icon': SvgPicture.asset('assets/icons/google.svg'),
                  'action': controller.googleAuthLogin,
                },
                {
                  'title': 'Continue with Facebook',
                  'icon': SvgPicture.asset('assets/icons/facebook.svg'),
                  'action': controller.facebookAuthLogin,
                },
                {
                  'title': 'Continue with mail',
                  'icon': SvgPicture.asset('assets/icons/mail.svg'),
                  'action': () {},
                },
              ]
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: AppButton(
                        title: e['title'] as String,
                        leading: SizedBox(
                          height: 20,
                          width: 20,
                          child: e['icon'] as Widget,
                        ),
                        width: 1.1,
                        backgroundColor: Theme.of(context).cardColor,
                        voidCallback: e['action'] as Function(),
                      ),
                    ),
                  )
                  .toList(),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 8, 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "By continuing, you argee to IWallet's ",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 11),
                    children: const [
                      TextSpan(
                          text: "Term of Use",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          )),
                      TextSpan(text: ". Read our Privacy Policy", children: [])
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter({super.repaint, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.shader = const LinearGradient(colors: [
      Color(0xffFD5E3D),
      Color(0xffC43990),
    ], begin: Alignment.topLeft, end: Alignment.bottomRight)
        .createShader(
      Rect.fromCircle(center: const Offset(0, 0), radius: radius),
    );
    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Mybehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
