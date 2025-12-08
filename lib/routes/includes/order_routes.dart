import 'package:bukuku_frontend/features/order/presentation/checkout/binding/order_checkout_binding.dart';
import 'package:bukuku_frontend/features/order/presentation/checkout/view/order_checkout_view.dart';
import 'package:bukuku_frontend/features/order/presentation/history/binding/order_history_binding.dart';
import 'package:bukuku_frontend/features/order/presentation/history/view/order_history_view.dart';
import 'package:bukuku_frontend/features/order/presentation/order/binding/order_binding.dart';
import 'package:bukuku_frontend/features/order/presentation/order/view/order_view.dart';
import 'package:get/get.dart';
import '../app_links.dart';

class OrderRoutes {
  static final pages = [
    GetPage(name: AppLinks.order, page: () => const OrderView(), binding: OrderBinding()),
    GetPage(name: AppLinks.orderCheckout, page: () => const OrderCheckoutView(), binding: OrderCheckoutBinding()),
    GetPage(name: AppLinks.orderHistory, page: () => const OrderHistoryView(), binding: OrderHistoryBinding()),
  ];
}
