
import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/features/menu_item/domain/entity/menu_item_entity.dart';
import 'package:bukuku_frontend/features/menu_item/domain/repository/menu_item_repository.dart';
import 'package:bukuku_frontend/features/order/domain/entity/cart_item.dart';
import 'package:bukuku_frontend/routes/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  OrderController(this.menuItemRepository);

  final MenuItemRepository menuItemRepository;

  final RxBool isLoading = false.obs;

  final RxList<MenuItemEntity> allMenuItems = RxList([]);

  final RxList<MenuItemEntity> displayedMenuItems = RxList([]);

  final RxList<CartItem> cartItems = RxList([]);

  // Search Controller
  final TextEditingController searchController = TextEditingController();

  // Total items count
  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Total price
  double get totalPrice => cartItems.fold(0, (sum, item) => sum + (item.menu.price * item.quantity));

  @override
  void onReady() {
    super.onReady();
    fetchMenu();
  }

  // --- FETCHING DATA ---
  void fetchMenu() async {
    isLoading.toggle();

    final res = await menuItemRepository.getAllMenuItems();

    res.fold(
      (e) => ToasterUtils.showError(message: e.message),
      (r) {
        allMenuItems.value = r.data?.items ?? [];
        displayedMenuItems.value = allMenuItems; // Initially show all
      },
    );

    isLoading.toggle();
  }

  void searchMenu(String query) {
    if (query.isEmpty) {
      displayedMenuItems.value = allMenuItems;
    } else {
      displayedMenuItems.value = allMenuItems.where((item) {
        return item.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void addToCart(MenuItemEntity item) {
    // Check if item is already in cart
    final index = cartItems.indexWhere((element) => element.menu.id == item.id);

    if (index != -1) {
      // Item exists, increment quantity
      cartItems[index].quantity++;
      cartItems.refresh();
    } else {
      // New item, add to list
      cartItems.add(CartItem(menu: item));
    }
  }

  void removeFromCart(MenuItemEntity item) {
    final index = cartItems.indexWhere((element) => element.menu.id == item.id);

    if (index == -1) return;

    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    } else {
      cartItems.removeAt(index);
    }
  }

  int getQuantity(MenuItemEntity item) {
    final cartItem = cartItems.firstWhereOrNull((element) => element.menu.id == item.id);
    return cartItem?.quantity ?? 0;
  }

  void onTapCheckout() {
    Get.toNamed(AppLinks.orderCheckout);
  }
}
