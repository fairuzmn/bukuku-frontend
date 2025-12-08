import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/features/auth/presentation/otp/controller/otp_controller.dart';
import 'package:bukuku_frontend/shared/components/buttons/elevated_button.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginOtpView extends GetView<LoginOtpController> {
  const LoginOtpView({super.key});

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.chevron_left),
                ),
                AppSpacing.space40.verticalSpace,
                Center(
                  child: Text(
                    "We sent you a code",
                    style: AppTypography.paragraph2,
                  ),
                ),
                AppSpacing.space8.verticalSpace,
                Center(
                  child: Text(
                    "Enter it below to verify",
                    style: AppTypography.paragraph4.copyWith(
                      color: AppColor.darkShade50,
                    ),
                  ),
                ),
                AppSpacing.space32.verticalSpace,
                OtpTextField(
                  fieldWidth: 45.w,
                  numberOfFields: 6,
                  enabledBorderColor: AppColor.darkShade25,
                  focusedBorderColor: AppColor.primary,
                  cursorColor: AppColor.primary,
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    controller.setOtp(verificationCode);
                  }, // end onSubmit
                ),
                AppSpacing.space16.verticalSpace,
                AppElevatedButton(
                  onPressed: () {
                    controller.onSubmit();
                  },
                  title: "Next",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
