import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/features/order/data/request/create_order_request.dart';
import 'package:bukuku_frontend/features/order/domain/repository/order_repository.dart';
import 'package:bukuku_frontend/features/order/presentation/order/controller/order_controller.dart';
import 'package:bukuku_frontend/features/table/domain/entity/table_entity.dart';
import 'package:bukuku_frontend/features/table/domain/repository/table_repository.dart';
import 'package:bukuku_frontend/routes/app_links.dart';
import 'package:get/get.dart';

class OrderCheckoutController extends GetxController {
  OrderCheckoutController(
    this.orderController,
    this.orderRepository,
    this.tableRepository,
  );

  final OrderController orderController;
  final OrderRepository orderRepository;
  final TableRepository tableRepository;

  // State
  final RxBool isLoading = false.obs;

  // Table Data
  final RxList<TableEntity> tables = <TableEntity>[].obs;
  final Rxn<TableEntity> selectedTable = Rxn<TableEntity>();

  @override
  void onInit() {
    super.onInit();
    fetchTables();
  }

  void fetchTables() async {
    final res = await tableRepository.getAllTables();
    res.fold(
      (e) => ToasterUtils.showError(message: "Failed to load tables"),
      (r) {
        tables.value = r.data?.tables ?? [];
      },
    );
  }

  void submitOrder() async {
    if (selectedTable.value == null) {
      ToasterUtils.showError(message: "Please select a table");
      return;
    }

    if (orderController.cartItems.isEmpty) {
      ToasterUtils.showError(message: "Your cart is empty");
      return;
    }

    isLoading.toggle();

    // Map Cart Items to API Request
    List<OrderItemRequest> apiItems = orderController.cartItems.map((cartItem) {
      return OrderItemRequest(
        menuItemId: cartItem.menu.id,
        quantity: cartItem.quantity,
      );
    }).toList();

    final res = await orderRepository.createOrder(
      CreateOrderRequest(
        tableId: selectedTable.value!.id,
        items: apiItems,
      ),
    );

    res.fold(
      (e) {
        isLoading.toggle();
        ToasterUtils.showError(message: e.message);
      },
      (r) {
        isLoading.toggle();
        orderController.cartItems.clear();
        Get.until((route) => Get.currentRoute == AppLinks.dashboard);
        ToasterUtils.showSuccess(message: "Order placed successfully!");
      },
    );
  }
}
