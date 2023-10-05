import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iwallet/app/modules/initial/controllers/initial_controller.dart';

import 'app/routes/app_pages.dart';
import 'app/theme/app_theme.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  app = await Firebase.initializeApp();
  auth = FirebaseAuth.instanceFor(app: app);

  if (shouldUseFirebaseEmulator) {
    await auth.useAuthEmulator('localhost', 9099);
  }
  Get.lazyPut(() => InitialController());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = Get.find<InitialController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: "IWallet",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: controller.themeMode.value,
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        var isTablet = data.size.height >= 850 && data.size.height < 1100;
        return MediaQuery(
          data: data.copyWith(textScaleFactor: isTablet ? 1.01 : 1),
          child: child!,
        );
      },
      ),
    );
  }
}
