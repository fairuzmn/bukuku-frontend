import 'package:bukuku_frontend/features/kitchen/presentation/binding/kitchen_binding.dart';
import 'package:bukuku_frontend/features/kitchen/presentation/view/kitchen_view.dart';
import 'package:get/get.dart';
import '../app_links.dart';

class KitchenRoutes {
  static final pages = [
    GetPage(name: AppLinks.kitchen, page: () => const KitchenView(), binding: KitchenBinding()),
  ];
}
