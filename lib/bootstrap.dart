import 'package:bukuku_frontend/core/di/app_binding.dart';
import 'package:flutter/material.dart';
import 'core/env/app_env.dart';

Future<void> bootstrap({required AppEnv env}) async {
  WidgetsFlutterBinding.ensureInitialized();

  // register DI
  await AppBindings(env: env).dependencies();
}
