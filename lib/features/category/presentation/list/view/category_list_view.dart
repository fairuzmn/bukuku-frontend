import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/features/category/domain/entity/category.dart';
import 'package:bukuku_frontend/features/category/presentation/list/controller/category_controller.dart';
import 'package:bukuku_frontend/shared/components/buttons/floated_button.dart';
import 'package:bukuku_frontend/shared/components/buttons/icon_button.dart';
import 'package:bukuku_frontend/shared/components/shimmer/shimmer.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryListView extends GetView<CategoryController> {
  const CategoryListView({super.key});

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
                    "Manage Category",
                    style: AppTypography.headline3.copyWith(),
                  ),
                ],
              ),
              Obx(() {
                if (controller.isLoading.value) return SizedBox.shrink();

                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.space16,
                    vertical: AppSpacing.space16,
                  ),
                  child: Text(
                    "Showing ${controller.categories.length} items",
                    style: AppTypography.paragraph3.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColor.darkShade75,
                    ),
                  ),
                );
              }),
              Expanded(
                child: Padding(
                  padding: AppInsets.mainContent,
                  child: Obx(
                    () {
                      if (controller.isLoading.value) {
                        return ListView.separated(
                          padding: EdgeInsets.only(top: AppSpacing.space16),
                          itemCount: 6,
                          separatorBuilder: (BuildContext context, int index) {
                            return AppSpacing.space8.verticalSpace;
                          },
                          itemBuilder: (context, index) {
                            return AppShimmer.background(height: 50.h, width: 1.sw);
                          },
                        );
                      }

                      return ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: controller.categories.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return AppSpacing.space8.verticalSpace;
                        },
                        itemBuilder: (context, index) {
                          return _categoryItem(controller.categories[index]);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AppFloatedButton(
        icon: Icons.add,
        onTap: controller.add,
      ),
    );
  }

  Widget _categoryItem(CategoryEntity category) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.space12,
        vertical: AppSpacing.space8,
      ),
      decoration: BoxDecoration(
        color: AppColor.darkShade10.withValues(alpha: 0.5),
        borderRadius: AppRadius.md,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.name,
                style: AppTypography.paragraph3.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              AppSpacing.space2.verticalSpace,
              Text(
                category.description,
                style: AppTypography.paragraph4,
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  size: 20,
                ),
                onTap: () => controller.edit(category),
              ),
              AppIconButton(
                icon: Icon(
                  Icons.delete_outline,
                  size: 20,
                ),
                onTap: () => controller.delete(category),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
