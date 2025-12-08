import 'package:bukuku_frontend/features/menu_item/presentation/add/controller/menu_item_add_controller.dart';
import 'package:get/get.dart';

class MenuItemAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MenuItemAddController(Get.find(), Get.find()));
  }
}
