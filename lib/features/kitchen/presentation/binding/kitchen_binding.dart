import 'package:bukuku_frontend/features/kitchen/presentation/controller/kitchen_controller.dart';
import 'package:get/get.dart';

class KitchenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => KitchenController(Get.find()));
  }
}
