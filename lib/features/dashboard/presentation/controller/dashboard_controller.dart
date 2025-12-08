import 'package:bukuku_frontend/routes/app_links.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  void onTapCategory() {
    Get.toNamed(AppLinks.categoryList);
  }

  void onTapTable() {
    Get.toNamed(AppLinks.tableList);
  }

  void onTapFood() {
    Get.toNamed(AppLinks.menuItemList);
  }

  void onTapOrder() {
    Get.toNamed(AppLinks.order);
  }

  void onTapHistory() {
    Get.toNamed(AppLinks.orderHistory);
  }

  void onTapKitchen() {
    Get.toNamed(AppLinks.kitchen);
  }
}
