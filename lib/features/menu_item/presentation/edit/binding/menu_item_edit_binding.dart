import 'package:bukuku_frontend/features/menu_item/presentation/edit/controller/menu_item_edit_controller.dart';
import 'package:get/get.dart';

class MenuItemEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MenuItemEditController(Get.find(), Get.find()));
  }
}
