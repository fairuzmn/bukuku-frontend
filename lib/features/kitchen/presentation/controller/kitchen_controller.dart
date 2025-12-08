import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/features/kitchen/domain/repository/kitchen_repository.dart';
import 'package:bukuku_frontend/features/order/domain/entity/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KitchenController extends GetxController {
  KitchenController(this.kitchenRepository);

  final KitchenRepository kitchenRepository;

  final RxBool isLoading = false.obs;
  final RxList<OrderEntity> tickets = <OrderEntity>[].obs;

  @override
  void onReady() {
    super.onReady();
    fetchTickets();
  }

  void fetchTickets() async {
    isLoading.toggle();
    final res = await kitchenRepository.getKitchenTickets();

    res.fold(
      (e) => ToasterUtils.showError(message: e.message),
      (r) => tickets.value = r.data?.tickets ?? [],
    );

    isLoading.toggle();
  }

  void proceedOrder(OrderEntity order) {
    String nextStatus = "";
    if (order.status == 'pending') {
      nextStatus = 'processing';
    } else if (order.status == 'processing') {
      nextStatus = 'done';
    } else {
      return;
    }

    _updateStatusApi(order.id, nextStatus);
  }

  void _updateStatusApi(int id, String status) async {
    isLoading.toggle();
    final res = await kitchenRepository.updateTicketStatus(id, status);

    res.fold(
      (e) {
        isLoading.toggle();
        ToasterUtils.showError(message: e.message);
      },
      (r) {
        isLoading.toggle();
        ToasterUtils.showSuccess(message: "Order updated to $status");
        fetchTickets();
      },
    );
  }

  // Helper for Button Text
  String getButtonText(String status) {
    if (status == 'pending') return "Proceed to Cook";
    if (status == 'processing') return "Mark Complete";
    return "Details";
  }

  // Helper for Button Color
  Color getButtonColor(String status) {
    if (status == 'pending') return Colors.blue;
    if (status == 'processing') return Colors.green;
    return Colors.grey;
  }
}
