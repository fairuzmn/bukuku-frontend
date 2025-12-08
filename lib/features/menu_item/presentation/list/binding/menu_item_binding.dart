import 'package:bukuku_frontend/features/menu_item/presentation/list/controller/menu_item_controller.dart';
import 'package:get/get.dart';

class MenuItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MenuItemController(Get.find()));
  }
}
