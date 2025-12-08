import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/features/kitchen/presentation/controller/kitchen_controller.dart';
import 'package:bukuku_frontend/features/order/domain/entity/order_entity.dart';
import 'package:bukuku_frontend/shared/components/shimmer/shimmer.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class KitchenView extends GetView<KitchenController> {
  const KitchenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Kitchen", style: AppTypography.headline3),
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: controller.fetchTickets,
            icon: const Icon(Icons.refresh, color: Colors.black),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.fetchTickets(),
        child: Padding(
          padding: AppInsets.mainContent,
          child: Obx(() {
            if (controller.isLoading.value) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                itemCount: 3,
                separatorBuilder: (_, _) => AppSpacing.space16.verticalSpace,
                itemBuilder: (_, _) => AppShimmer.background(height: 180.h, width: 1.sw),
              );
            }

            if (controller.tickets.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
                    AppSpacing.space16.verticalSpace,
                    Text("All tickets cleared!", style: AppTypography.headline4),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              itemCount: controller.tickets.length,
              separatorBuilder: (_, _) => AppSpacing.space16.verticalSpace,
              itemBuilder: (context, index) {
                final ticket = controller.tickets[index];
                return _buildKitchenTicket(ticket);
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildKitchenTicket(OrderEntity order) {
    String timeStr = "";
    try {
      final date = DateTime.parse(order.createdAt);
      timeStr = DateFormat('HH:mm').format(date);
    } catch (e) {
      timeStr = "--:--";
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          left: BorderSide(
            color: order.status == 'pending' ? Colors.orange : Colors.blue,
            width: 6,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.table?.name ?? "Table #${order.tableId}",
                      style: AppTypography.headline4,
                    ),
                    Text(
                      "Ticket #${order.id}",
                      style: AppTypography.paragraph4.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    timeStr,
                    style: AppTypography.headline4.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: order.items.map((item) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 30.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "${item.quantity}",
                          style: AppTypography.paragraph3.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      AppSpacing.space12.horizontalSpace,
                      Expanded(
                        child: Text(
                          item.menuItemName,
                          style: AppTypography.paragraph3.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const Divider(height: 1),

          InkWell(
            onTap: () => controller.proceedOrder(order),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: controller.getButtonColor(order.status),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              ),
              alignment: Alignment.center,
              child: Text(
                controller.getButtonText(order.status).toUpperCase(),
                style: AppTypography.paragraph3.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
