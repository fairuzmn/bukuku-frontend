import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    required this.height,
    required this.width,
    this.radius,
    this.baseColor,
  });

  final double height;
  final double width;
  final double? radius;
  final Color? baseColor;

  factory AppShimmer.background({
    required double height,
    required double width,
  }) {
    return AppShimmer(
      height: height,
      width: width,
      baseColor: AppColor.darkShade50,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      height: height,
      width: width,
      radius: radius ?? AppSpacing.space8,
      highlightColor: (baseColor ?? AppColor.darkShade10).withValues(alpha: 0.3),
      baseColor: (baseColor ?? AppColor.darkShade10),
    );
  }
}
