import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/core/extensions/double_extensions.dart';
import 'package:bukuku_frontend/features/menu_item/domain/entity/menu_item_entity.dart';
import 'package:bukuku_frontend/features/menu_item/presentation/list/controller/menu_item_controller.dart';
import 'package:bukuku_frontend/shared/components/buttons/floated_button.dart';
import 'package:bukuku_frontend/shared/components/buttons/icon_button.dart';
import 'package:bukuku_frontend/shared/components/image/image.dart';
import 'package:bukuku_frontend/shared/components/shimmer/shimmer.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MenuItemListView extends GetView<MenuItemController> {
  const MenuItemListView({super.key});

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
                    "Manage Food",
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
                    "Showing ${controller.items.length} items",
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
                        itemCount: controller.items.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return AppSpacing.space8.verticalSpace;
                        },
                        itemBuilder: (context, index) {
                          return _categoryItem(controller.items[index]);
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

  Widget _categoryItem(MenuItemEntity item) {
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
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadius.md,
            ),
            child: AppImage(
              path: item.imageUrl,
              width: 0.2.sw,
              height: 70.h,
            ),
          ),
          AppSpacing.space8.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTypography.paragraph3.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                AppSpacing.space2.verticalSpace,

                Text(
                  item.price.toIDR,
                  style: AppTypography.paragraph4,
                ),
                AppSpacing.space2.verticalSpace,
                Text(
                  item.description ?? "",
                  style: AppTypography.paragraph4,
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  size: 20,
                ),
                onTap: () => controller.edit(item),
              ),
              AppIconButton(
                icon: Icon(
                  Icons.delete_outline,
                  size: 20,
                ),
                onTap: () => controller.delete(item),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
