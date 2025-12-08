import 'package:bukuku_frontend/features/splash/presentation/binding/splash_binding.dart';
import 'package:bukuku_frontend/features/splash/presentation/view/splash_view.dart';
import 'package:get/get.dart';
import '../app_links.dart';

class SplashRoutes {
  static final pages = [
    GetPage(name: AppLinks.splash, page: () => const SplashView(), binding: SplashBinding()),
  ];
}
