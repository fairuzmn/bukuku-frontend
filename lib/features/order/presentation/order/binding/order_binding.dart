import 'package:bukuku_frontend/features/order/presentation/order/controller/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController(Get.find()));
  }
}
