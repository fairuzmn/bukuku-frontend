import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialogUtils {
  static void confirmDeleteDialog({
    required String title,
    required String desc,
    required VoidCallback onConfirm,
  }) {
    Get.dialog(
      AlertDialog(
        title: Text(
          title,
          style: AppTypography.paragraph2,
        ),
        content: Text(desc),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              onConfirm();
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
