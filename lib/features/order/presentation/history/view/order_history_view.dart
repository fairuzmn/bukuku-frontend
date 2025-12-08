import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/core/extensions/double_extensions.dart';
import 'package:bukuku_frontend/features/order/domain/entity/order_entity.dart';
import 'package:bukuku_frontend/features/order/presentation/history/controller/order_history_controller.dart';
import 'package:bukuku_frontend/shared/components/shimmer/shimmer.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderHistoryView extends GetView<OrderHistoryController> {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text("Order History", style: AppTypography.headline3),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: controller.fetchOrders,
            icon: const Icon(Icons.refresh, color: Colors.black),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.fetchOrders(),
        child: Padding(
          padding: AppInsets.mainContent,
          child: Obx(() {
            if (controller.isLoading.value) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                itemCount: 5,
                separatorBuilder: (_, _) => AppSpacing.space12.verticalSpace,
                itemBuilder: (_, _) => AppShimmer.background(height: 120.h, width: 1.sw),
              );
            }

            if (controller.orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.receipt_long_rounded, size: 64, color: Colors.grey),
                    AppSpacing.space16.verticalSpace,
                    Text("No orders found", style: AppTypography.paragraph3.copyWith(color: Colors.grey)),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              itemCount: controller.orders.length,
              separatorBuilder: (_, _) => AppSpacing.space12.verticalSpace,
              itemBuilder: (context, index) {
                final order = controller.orders[index];
                return _buildOrderCard(order);
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrderEntity order) {
    String dateStr = "";
    try {
      final date = DateTime.parse(order.createdAt);
      dateStr = DateFormat('dd MMM, HH:mm').format(date);
    } catch (e) {
      dateStr = order.createdAt;
    }

    return InkWell(
      onTap: () => controller.goToDetail(order),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER: Table & Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColor.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        order.table?.name ?? "Table #${order.tableId}",
                        style: AppTypography.paragraph3.copyWith(
                          color: AppColor.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      dateStr,
                      style: AppTypography.paragraph4.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
                _buildStatusBadge(order.status),
              ],
            ),

            AppSpacing.space12.verticalSpace,
            const Divider(height: 1),
            AppSpacing.space12.verticalSpace,

            ...order.items
                .take(3)
                .map(
                  (item) => Padding(
                    padding: EdgeInsets.only(bottom: 4.h),
                    child: Row(
                      children: [
                        Text(
                          "${item.quantity}x",
                          style: AppTypography.paragraph4.copyWith(
                            color: AppColor.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            item.menuItemName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.paragraph4.copyWith(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

            if (order.items.length > 3)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  "+ ${order.items.length - 3} more items",
                  style: AppTypography.paragraph3.copyWith(color: Colors.grey),
                ),
              ),

            AppSpacing.space12.verticalSpace,

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Total: ", style: AppTypography.paragraph4),
                Text(
                  order.totalAmount.toIDR,
                  style: AppTypography.paragraph3.copyWith(fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final color = controller.getStatusColor(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status.toUpperCase(),
        style: AppTypography.paragraph3.copyWith(
          color: color,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
