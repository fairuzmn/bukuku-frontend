import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/features/order/domain/entity/order_entity.dart';
import 'package:bukuku_frontend/features/order/domain/repository/order_repository.dart';
import 'package:bukuku_frontend/routes/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderHistoryController extends GetxController {
  OrderHistoryController(this.orderRepository);

  final OrderRepository orderRepository;

  final RxBool isLoading = false.obs;
  final RxList<OrderEntity> orders = <OrderEntity>[].obs;

  @override
  void onReady() {
    super.onReady();
    fetchOrders();
  }

  void fetchOrders() async {
    isLoading.toggle();

    final res = await orderRepository.getAllOrders();

    res.fold(
      (e) => ToasterUtils.showError(message: e.message),
      (r) => orders.value = r.data?.orders ?? [],
    );

    isLoading.toggle();
  }

  void goToDetail(OrderEntity order) {
    Get.toNamed(AppLinks.orderDetail, arguments: order);
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'completed':
      case 'paid':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
