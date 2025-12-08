import 'package:bukuku_frontend/features/dashboard/presentation/binding/dashboard_binding.dart';
import 'package:bukuku_frontend/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:get/get.dart';
import '../app_links.dart';

class DashboardRoutes {
  static final pages = [
    GetPage(name: AppLinks.dashboard, page: () => const DashboardView(),  binding: DashboardBinding()),
  ];
}
