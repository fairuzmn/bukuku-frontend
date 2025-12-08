import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/shared/components/form/text_input.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextInputPassword extends StatelessWidget {
  const AppTextInputPassword({super.key, this.controller, this.errorText, this.onChanged});

  final TextEditingController? controller;
  final String? errorText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (data) => AppTextInput(
        hint: "Password",
        controller: controller,
        errorText: errorText,
        obscureText: data.value,
        prefixIcon: Icons.lock_outline,
        maxLines: 1,
        suffixIconWidget: Padding(
          padding: EdgeInsets.only(left: AppSpacing.space4, right: AppSpacing.space4),
          child: IconButton(
            onPressed: () {
              data.toggle();
            },
            icon: Icon(
              data.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: AppColor.darkShade75,
            ),
          ),
        ),
      ),
      true.obs,
    );
  }
}
