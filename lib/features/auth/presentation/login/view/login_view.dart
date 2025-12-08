import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/features/auth/presentation/login/controller/login_controller.dart';
import 'package:bukuku_frontend/shared/components/buttons/elevated_button.dart';
import 'package:bukuku_frontend/shared/components/form/text_input.dart';
import 'package:bukuku_frontend/shared/components/form/text_input_password.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppInsets.mainContent,
        child: SafeArea(
          child: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppSpacing.space40.verticalSpace,
                Text(
                  "Login in to your account",
                  style: AppTypography.paragraph2,
                ),
                AppSpacing.space32.verticalSpace,
                Obx(
                  () => AppTextInput(
                    hint: "Email",
                    prefixIcon: Icons.email_outlined,
                    controller: controller.emailController,
                    errorText: controller.emailError.value,
                    onChanged: (e) => controller.emailError.value = null,
                  ),
                ),
                AppSpacing.space16.verticalSpace,
                Obx(
                  () => AppTextInputPassword(
                    controller: controller.passwordController,
                    errorText: controller.passwordError.value,
                    onChanged: (e) => controller.passwordError.value = null,
                  ),
                ),
                AppSpacing.space32.verticalSpace,
                AppElevatedButton(
                  onPressed: controller.onSubmit,
                  title: "Login",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
