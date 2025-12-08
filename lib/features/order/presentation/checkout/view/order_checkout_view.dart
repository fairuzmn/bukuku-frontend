import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/core/extensions/double_extensions.dart';
import 'package:bukuku_frontend/features/order/domain/entity/cart_item.dart';
import 'package:bukuku_frontend/features/order/presentation/checkout/controller/order_checkout_controller.dart';
import 'package:bukuku_frontend/features/table/domain/entity/table_entity.dart';
import 'package:bukuku_frontend/shared/components/buttons/elevated_button.dart';
import 'package:bukuku_frontend/shared/components/image/image.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OrderCheckoutView extends GetView<OrderCheckoutController> {
  const OrderCheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Checkout", style: AppTypography.headline3),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      bottomNavigationBar: _buildBottomPaymentBar(),
      body: SingleChildScrollView(
        padding: AppInsets.mainContent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.space16.verticalSpace,

            // --- NEW: TABLE SELECTION SECTION ---
            Text("Table Info", style: AppTypography.headline4),
            AppSpacing.space12.verticalSpace,
            _buildTableSelector(),
            AppSpacing.space24.verticalSpace,

            // ------------------------------------
            Text("Order Items", style: AppTypography.headline4),
            AppSpacing.space12.verticalSpace,

            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.orderController.cartItems.length,
                separatorBuilder: (_, _) => AppSpacing.space12.verticalSpace,
                itemBuilder: (context, index) {
                  final cartItem = controller.orderController.cartItems[index];
                  return _buildCartItemTile(cartItem);
                },
              ),
            ),

            AppSpacing.space24.verticalSpace,

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total", style: AppTypography.headline4),
                      Obx(
                        () => Text(
                          (controller.orderController.totalPrice * 1.1).toIDR,
                          style: AppTypography.headline4.copyWith(color: AppColor.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            100.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemTile(CartItem cartItem) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AppImage(
              path: cartItem.menu.imageUrl,
              width: 60.w,
              height: 60.w,
              fit: BoxFit.cover,
            ),
          ),
          AppSpacing.space12.horizontalSpace,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.menu.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.paragraph3.copyWith(fontWeight: FontWeight.w700),
                ),
                AppSpacing.space4.verticalSpace,
                Text(
                  cartItem.menu.price.toIDR,
                  style: AppTypography.paragraph4.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                _iconButton(Icons.remove, () => controller.orderController.removeFromCart(cartItem.menu)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Text(
                    cartItem.quantity.toString(),
                    style: AppTypography.paragraph3.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                _iconButton(Icons.add, () => controller.orderController.addToCart(cartItem.menu)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: AppColor.primary),
      ),
    );
  }

  Widget _buildBottomPaymentBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        child: AppElevatedButton(
          title: "Checkout",
          onPressed: controller.submitOrder,
        ),
      ),
    );
  }

  Widget _buildTableSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Obx(() {
        if (controller.tables.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Loading tables...", style: AppTypography.paragraph3),
          );
        }

        return DropdownButtonHideUnderline(
          child: DropdownButton<TableEntity>(
            value: controller.selectedTable.value,
            hint: Text("Select Table", style: AppTypography.paragraph3),
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            items: controller.tables.map((table) {
              final isOccupied = table.status == TableStatus.occupied;
              final isReserved = table.status == TableStatus.reserved;

              return DropdownMenuItem<TableEntity>(
                value: table,
                child: Row(
                  children: [
                    Icon(Icons.table_restaurant_rounded, size: 20, color: isOccupied ? Colors.grey : AppColor.primary),
                    SizedBox(width: 12.w),
                    Text(
                      table.name,
                      style: AppTypography.paragraph3.copyWith(
                        color: isOccupied ? Colors.grey : Colors.black,
                        decoration: isOccupied ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (isOccupied) Text(" (Occupied)", style: TextStyle(color: Colors.red, fontSize: 12)),
                    if (isReserved) Text(" (Reserved)", style: TextStyle(color: AppColor.primary, fontSize: 12)),
                  ],
                ),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null && val.status != TableStatus.occupied) {
                controller.selectedTable.value = val;
              } else {
                //
              }
            },
          ),
        );
      }),
    );
  }
}
