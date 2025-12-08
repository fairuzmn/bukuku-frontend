import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ToasterUtils {
  static void show({
    required Widget child,
    EdgeInsets? padding,
    EdgeInsets? margin,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Color? backgroundColor,
    double? borderRadius,
    Duration? duration,
    bool replacePrevious = false,
  }) {
    if (replacePrevious) {
      Get.closeAllSnackbars();
    }

    Get.showSnackbar(
      GetSnackBar(
        messageText: child,
        snackPosition: snackPosition,
        padding: padding ?? EdgeInsets.all(10.h),
        margin: margin ?? EdgeInsets.only(bottom: 30.h, left: 22.5.w, right: 22.5.w),
        backgroundColor: backgroundColor ?? const Color(0xFF303030),
        borderRadius: borderRadius ?? 8,
        duration: duration ?? const Duration(milliseconds : 800),
      ),
    );
  }

  static void showError({
    required String message,
    bool withClose = false,
    bool withIcon = true,
    Duration? duration,
    bool replacePrevious = false,
  }) {
    ToasterUtils.show(
      replacePrevious: replacePrevious,
      backgroundColor: AppColor.danger,
      duration: duration,
      child: Row(
        children: [
          Visibility(
            visible: withIcon,
            child: IconButton(
              icon: Icon(
                Icons.cancel_outlined,
                color: Colors.white,
                weight: 24.w,
              ),
              onPressed: () {
                if (replacePrevious) {
                  Get.closeAllSnackbars();
                  return;
                }

                Get.closeCurrentSnackbar();
              },
            ),
          ),
          SizedBox(width: withIcon ? 0 : 10.w),
          Expanded(
            child: Text(
              message,
              style: AppTypography.paragraph3.copyWith(color: Colors.white),
            ),
          ),
          SizedBox(width: 10.w),
          Visibility(
            visible: withClose,
            child: SizedBox(
              height: 24.h,
              width: 24.w,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  if (replacePrevious) {
                    Get.closeAllSnackbars();
                    return;
                  }

                  Get.closeCurrentSnackbar();
                },
                icon: const Icon(
                  Icons.close,
                  // color: Palette.conditionWarningMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void showSuccess({
    required String message,
    Duration? duration,
    bool replacePrevious = false,
  }) {
    ToasterUtils.show(
      replacePrevious: replacePrevious,
      backgroundColor: AppColor.success,
      duration: duration,
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.white,
            weight: 24.w,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              message,
              style: AppTypography.paragraph3.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
