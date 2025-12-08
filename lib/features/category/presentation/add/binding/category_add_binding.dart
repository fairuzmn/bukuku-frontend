import 'package:bukuku_frontend/features/category/presentation/add/controller/category_add_controller.dart';
import 'package:get/get.dart';

class CategoryAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryAddController(Get.find()));
  }
}
