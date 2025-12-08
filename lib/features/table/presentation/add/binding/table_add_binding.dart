import 'package:bukuku_frontend/features/table/presentation/add/controller/table_add_controller.dart';
import 'package:get/get.dart';

class TableAddBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TableAddController(Get.find()));
  }
}
