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
    return GetMaterialApp(
      title: "IWallet",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: controller.themeMode.value,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
