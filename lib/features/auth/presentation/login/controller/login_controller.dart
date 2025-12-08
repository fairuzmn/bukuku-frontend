import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/core/utils/form/validator_utils.dart';
import 'package:bukuku_frontend/features/auth/data/request/login_request.dart';
import 'package:bukuku_frontend/features/auth/domain/respository/auth_repository.dart';
import 'package:bukuku_frontend/routes/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController({
    required this.authRepository,
  });

  final AuthRepository authRepository;

  final TextEditingController emailController = TextEditingController();
  final RxnString emailError = RxnString();

  final TextEditingController passwordController = TextEditingController();
  final RxnString passwordError = RxnString();

  bool validateForm() {
    emailError.value = ValidatorChain(emailController.text).required().email().result();
    passwordError.value = ValidatorUtils.required(passwordController.text);

    return emailError.value == null && passwordError.value == null;
  }

  void onSubmit() async {
    if (!validateForm()) return;

    var res = await authRepository.login(
      LoginRequest(email: emailController.text, password: passwordController.text),
    );

    res.fold(
      (e) {
        // TODO: should be comparing class not string but still broken
        if (e.message.toLowerCase().contains("unauthorized")) {
          ToasterUtils.showError(message: "Invalid Credentials");
          return;
        }

        ToasterUtils.showError(message: e.message);
      },
      (r) {
        Get.toNamed(AppLinks.authLoginOtp);
      },
    );
  }
}
