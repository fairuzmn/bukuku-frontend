class CreateOrderRequest {
  final int tableId;
  final List<OrderItemRequest> items;

  CreateOrderRequest({
    required this.tableId,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'table_id': tableId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderItemRequest {
  final int menuItemId;
  final int quantity;

  OrderItemRequest({
    required this.menuItemId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'menu_item_id': menuItemId,
      'quantity': quantity,
    };
  }
}
