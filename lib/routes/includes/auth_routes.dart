import 'package:bukuku_frontend/features/auth/presentation/login/binding/login_binding.dart';
import 'package:bukuku_frontend/features/auth/presentation/login/view/login_view.dart';
import 'package:bukuku_frontend/features/auth/presentation/otp/binding/otp_binding.dart';
import 'package:bukuku_frontend/features/auth/presentation/otp/view/otp_view.dart';
import 'package:get/get.dart';
import '../app_links.dart';

class AuthRoutes {
  static final pages = [
    GetPage(name: AppLinks.authLogin, page: () => const LoginView(), binding: LoginBinding()),
    GetPage(name: AppLinks.authLoginOtp, page: () => const LoginOtpView(), binding: LoginOtpBinding()),
  ];
}
