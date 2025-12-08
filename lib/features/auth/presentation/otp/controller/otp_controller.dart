import 'package:bukuku_frontend/core/session/session_controller.dart';
import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/features/auth/data/request/validate_otp_request.dart';
import 'package:bukuku_frontend/features/auth/domain/respository/auth_repository.dart';
import 'package:bukuku_frontend/features/auth/presentation/login/controller/login_controller.dart';
import 'package:bukuku_frontend/routes/app_links.dart';
import 'package:get/get.dart';

class LoginOtpController extends GetxController {
  LoginOtpController({
    required this.authRepository,
    required this.sessionController,
  });

  final AuthRepository authRepository;
  final SessionController sessionController;

  final RxString otp = "".obs;

  void setOtp(String newOtp) {
    otp.value = newOtp;
  }

  void onSubmit() async {
    if (otp.value.length != 6) return;

    var res = await authRepository.validateOtp(
      ValidateOtpRequest(
        email: Get.find<LoginController>().emailController.text,
        otp: otp.value,
      ),
    );

    res.fold(
      (e) {
        ToasterUtils.showError(message: e.message);
      },
      (r) {
        sessionController.setNewUser(r.data!.user);
        Get.toNamed(AppLinks.dashboard);
      },
    );
  }
}
