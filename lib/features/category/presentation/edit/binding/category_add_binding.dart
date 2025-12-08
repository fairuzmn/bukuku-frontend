import 'package:bukuku_frontend/features/category/presentation/edit/controller/category_edit_controller.dart';
import 'package:get/get.dart';

class CategoryEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryEditController(Get.find()));
  }
}
