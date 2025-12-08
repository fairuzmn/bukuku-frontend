import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/core/extensions/double_extensions.dart';
import 'package:bukuku_frontend/features/menu_item/domain/entity/menu_item_entity.dart';
import 'package:bukuku_frontend/features/order/presentation/order/controller/order_controller.dart';
import 'package:bukuku_frontend/shared/components/buttons/elevated_button.dart';
import 'package:bukuku_frontend/shared/components/image/image.dart';
import 'package:bukuku_frontend/shared/components/shimmer/shimmer.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderView extends GetView<OrderController> {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomCartBar(),
      body: Padding(
        padding: AppInsets.mainContent,
        child: SafeArea(
          child: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.space8.verticalSpace,
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        "Order",
                        style: AppTypography.headline3.copyWith(),
                      ),
                    ],
                  ),
                  AppSpacing.space12.verticalSpace,
                  Obx(() {
                    if (controller.isLoading.isTrue) {
                      return GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.72,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(4, (index) => AppShimmer.background(height: 100.h, width: 1.sw)),
                      );
                    }

                    return GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.72,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: controller.displayedMenuItems.map((e) => menuItemContainer(e)).toList(),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomCartBar() {
    return Obx(() {
      if (controller.totalItems == 0) return const SizedBox.shrink();

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.05),
              offset: const Offset(0, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${controller.totalItems} Items",
                    style: AppTypography.paragraph3.copyWith(
                      color: AppColor.darkShade50,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    controller.totalPrice.toIDR,
                    style: AppTypography.headline3.copyWith(
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
              const Spacer(),

              SizedBox(
                width: 0.3.sw,
                child: AppElevatedButton(
                  title: "Checkout",
                  onPressed: controller.onTapCheckout,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget menuItemContainer(MenuItemEntity item) {
    return InkWell(
      onTap: () => controller.addToCart(item),
      borderRadius: AppRadius.md,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppRadius.md,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 6,
              spreadRadius: 0,
              color: Colors.black.withValues(alpha:0.15),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AppImage(
                  path: item.imageUrl,
                  height: 100.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Obx(() {
                  final qty = controller.getQuantity(item);
                  if (qty == 0) return const SizedBox.shrink();

                  return Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      backgroundColor: AppColor.primary,
                      radius: 12,
                      child: Text(
                        qty.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(AppSpacing.space12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.paragraph3.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    AppSpacing.space4.verticalSpace,
                    Expanded(
                      child: Text(
                        item.description ?? "",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.paragraph4.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColor.darkShade50,
                        ),
                      ),
                    ),
                    AppSpacing.space4.verticalSpace,
                    Text(
                      item.price.toIDR,
                      style: AppTypography.paragraph3.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppColor.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
