import 'package:bukuku_frontend/features/table/presentation/list/controller/table_controller.dart';
import 'package:get/get.dart';

class TableBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TableController(Get.find()));
  }
}
