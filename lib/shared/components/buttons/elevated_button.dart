import 'dart:async';
import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class AppElevatedButton extends StatelessWidget {
  final String? title;
  final FutureOr<void> Function() onPressed;
  final bool enable;

  /// Optional visual parts
  final Widget? prefixWidget;
  final Widget? suffixWidget;

  /// Style overrides
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final MainAxisSize? mainAxisSize;

  const AppElevatedButton({
    super.key,
    required this.onPressed,
    this.title,
    this.enable = true,
    this.prefixWidget,
    this.suffixWidget,
    this.style,
    this.textStyle,
    this.mainAxisSize,
  });

  ButtonStyle get _defaultStyle {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColor.primary,
      minimumSize: Size(1.sw, 44.h),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.md,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TapDebouncer(
      onTap: () async => await onPressed(),
      builder: (context, debouncedOnTap) {
        return ElevatedButton(
          style: style ?? _defaultStyle,
          onPressed: enable ? debouncedOnTap : null,
          child: Row(
            mainAxisSize: mainAxisSize ?? MainAxisSize.min,
            children: [
              if (prefixWidget != null) ...[
                prefixWidget!,
                SizedBox(width: AppSpacing.space4),
              ],
              if (title != null)
                Text(
                  title!,
                  style:
                      textStyle ??
                      AppTypography.headline5.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
              if (suffixWidget != null) ...[
                const SizedBox(width: 8),
                suffixWidget!,
              ],
            ],
          ),
        );
      },
    );
  }
}
