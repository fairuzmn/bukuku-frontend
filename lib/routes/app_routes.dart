import 'package:bukuku_frontend/routes/includes/auth_routes.dart';
import 'package:bukuku_frontend/routes/includes/category_routes.dart';
import 'package:bukuku_frontend/routes/includes/dashboard_routes.dart';
import 'package:bukuku_frontend/routes/includes/kitchen_routes.dart';
import 'package:bukuku_frontend/routes/includes/menu_item_routes.dart';
import 'package:bukuku_frontend/routes/includes/order_routes.dart';
import 'package:bukuku_frontend/routes/includes/splash_routes.dart';
import 'package:bukuku_frontend/routes/includes/table_routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    ...AuthRoutes.pages,
    ...DashboardRoutes.pages,
    ...SplashRoutes.pages,
    ...CategoryRoutes.pages,
    ...TableRoutes.pages,
    ...MenuItemRoutes.pages,
    ...OrderRoutes.pages,
    ...KitchenRoutes.pages,
  ];
}
