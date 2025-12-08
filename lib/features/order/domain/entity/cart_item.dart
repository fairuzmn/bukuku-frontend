import 'package:bukuku_frontend/features/menu_item/domain/entity/menu_item_entity.dart';

class CartItem {
  final MenuItemEntity menu;
  int quantity;

  CartItem({
    required this.menu,
    this.quantity = 1,
  });
}