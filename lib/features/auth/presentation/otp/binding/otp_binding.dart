import 'package:bukuku_frontend/features/auth/presentation/otp/controller/otp_controller.dart';
import 'package:get/get.dart';

class LoginOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginOtpController(
        authRepository: Get.find(),
        sessionController: Get.find(),
      ),
    );
  }
}
