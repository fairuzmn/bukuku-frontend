import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextInput extends StatelessWidget {
  const AppTextInput({
    super.key,
    this.maxLines,
    this.minLines,
    this.hint,
    this.controller,
    this.inputFormatters = const [],
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.obscureText = false,
    this.suffixIconWidget,
    this.onChanged,
    this.enabled = true,
  });

  final int? maxLines;
  final int? minLines;
  final String? hint;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final Widget? suffixIconWidget;

  final String? errorText;
  final bool obscureText;

  final Function(String)? onChanged;
  final bool enabled;

  bool get hasError => errorText != null;

  Widget? get _hint {
    if (hint == null) return null;

    return Text(
      hint.toString(),
      style: AppTypography.paragraph2.copyWith(
        color: AppColor.darkShade75,
        fontSize: 14.sp,
      ),
    );
  }

  Widget? get _prefixIcon {
    if (prefixIcon == null) return null;

    var icon = prefixIcon;

    return Padding(
      padding: EdgeInsets.only(left: AppSpacing.space16, right: AppSpacing.space8),
      child: Icon(
        icon,
        color: AppColor.darkShade75,
      ),
    );
  }

  Widget? get _suffixIcon {
    if (suffixIcon == null && suffixIconWidget == null) return null;

    if (suffixIconWidget != null) {
      return suffixIconWidget;
    }

    return Padding(
      padding: EdgeInsets.only(right: AppSpacing.space16, left: AppSpacing.space8),
      child: Icon(
        suffixIcon,
        color: AppColor.darkShade75,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          enabled: enabled,
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          autofocus: false,
          obscureText: obscureText,
          style: AppTypography.paragraph2.copyWith(
            color: AppColor.darkShade,
            fontSize: 14.sp,
          ),
          onTapOutside: (_) => FocusScope.of(context).unfocus(),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hint: _hint,
            prefixIcon: _prefixIcon,
            suffixIcon: _suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.md,
              borderSide: BorderSide(
                color: hasError ? AppColor.danger : AppColor.darkShade10,
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.md,
              borderSide: BorderSide(
                color: hasError ? AppColor.danger : AppColor.darkShade10,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.md,
              borderSide: BorderSide(
                color: AppColor.primary,
                width: 2.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
          ),
        ),
        Visibility(
          visible: errorText != null,
          child: Padding(
            padding: EdgeInsets.only(top: AppSpacing.space4, left: AppSpacing.space4),
            child: Text(
              errorText ?? "",
              style: AppTypography.paragraph4.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColor.danger,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
