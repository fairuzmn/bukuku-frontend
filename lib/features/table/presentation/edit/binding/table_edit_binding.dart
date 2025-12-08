import 'package:bukuku_frontend/features/table/presentation/edit/controller/table_edit_controller.dart';
import 'package:get/get.dart';

class TableEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TableEditController(Get.find()));
  }
}
