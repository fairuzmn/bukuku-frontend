import 'dart:async';
import 'package:bukuku_frontend/core/constant/screen_utils_constant.dart';
import 'package:bukuku_frontend/routes/app_links.dart';
import 'package:bukuku_frontend/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'bootstrap.dart';
import 'core/env/app_env.dart';

Future<void> app({required AppEnv env}) async {
  await runZonedGuarded<Future<void>>(
    () async {
      await bootstrap(env: env);
      runApp(
        ScreenUtilInit(
          designSize: ScreenUtilsConstant.designSize,
          ensureScreenSize: true,
          fontSizeResolver: (fontSize, instance) => FontSizeResolvers.radius(fontSize, instance),
          builder: (context, widget) => const AppRoot(),
        ),
      );
    },
    (error, stack) {
      print(error);
      print(stack);
      // talker.error("🚨 Crash detected! ", error, stack);
    },
  );
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      title: "Bukuku - Restaurant",
      initialRoute: AppLinks.splash,
      getPages: AppRoutes.pages,
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('id', 'ID'),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      // defaultTransition: Transition.cupertino,
    );
  }
}
