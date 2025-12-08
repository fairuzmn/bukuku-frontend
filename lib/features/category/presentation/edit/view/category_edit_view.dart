import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/features/category/presentation/edit/controller/category_edit_controller.dart';
import 'package:bukuku_frontend/shared/components/buttons/elevated_button.dart';
import 'package:bukuku_frontend/shared/components/form/text_input.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryEditView extends GetView<CategoryEditController> {
  const CategoryEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    "Edit Category",
                    style: AppTypography.headline3.copyWith(),
                  ),
                ],
              ),
              Padding(
                padding: AppInsets.mainContent,
                child: Column(
                  children: [
                    AppSpacing.space32.verticalSpace,
                    Obx(
                      () => AppTextInput(
                        hint: "Name",
                        controller: controller.nameController,
                        errorText: controller.nameError.value,
                        onChanged: (e) => controller.nameError.value = null,
                      ),
                    ),
                    AppSpacing.space16.verticalSpace,
                    Obx(
                      () => AppTextInput(
                        hint: "Description",
                        controller: controller.descController,
                        errorText: controller.descError.value,
                        onChanged: (e) => controller.descError.value = null,
                      ),
                    ),
                    AppSpacing.space32.verticalSpace,
                    AppElevatedButton(
                      onPressed: controller.onSubmit,
                      title: "Submit",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
