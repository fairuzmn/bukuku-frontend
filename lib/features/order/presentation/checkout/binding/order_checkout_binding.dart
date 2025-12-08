import 'package:bukuku_frontend/features/order/presentation/checkout/controller/order_checkout_controller.dart';
import 'package:get/get.dart';

class OrderCheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderCheckoutController(Get.find(), Get.find(), Get.find()));
  }
}
