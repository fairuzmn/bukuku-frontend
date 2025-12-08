import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.borderRadius,
    this.padding,
  });

  final Widget icon;
  final VoidCallback onTap;

  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  BorderRadius get _borderRadius {
    return borderRadius ?? AppRadius.sm;
  }

  EdgeInsetsGeometry get _padding {
    return padding ?? EdgeInsets.all(AppSpacing.space8);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: _borderRadius,
      child: InkWell(
        borderRadius: _borderRadius,
        onTap: onTap,
        child: Padding(
          padding: _padding,
          child: icon,
        ),
      ),
    );
  }
}
