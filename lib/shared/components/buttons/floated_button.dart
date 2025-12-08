import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppFloatedButton extends StatelessWidget {
  const AppFloatedButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.primary,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.space16),
          child: Icon(icon, size: 24, color: Colors.white),
        ),
      ),
    );
  }
}
