import 'package:bukuku_frontend/features/table/domain/entity/table_entity.dart';

class OrderEntity {
  final int id;
  final int tableId;
  final int userId;
  final String status;
  final double totalAmount;
  final String createdAt;
  final TableEntity? table;
  final List<OrderItemEntity> items;

  const OrderEntity({
    required this.id,
    required this.tableId,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.createdAt,
    this.table,
    this.items = const [],
  });

  factory OrderEntity.fromJson(Map<String, dynamic> json) {
    return OrderEntity(
      id: json['id'],
      tableId: json['table_id'],
      userId: json['user_id'],
      status: json['status'],
      totalAmount: double.tryParse(json['total_amount'].toString()) ?? 0.0,
      createdAt: json['created_at'],
      table: json['table'] != null ? TableEntity.fromJson(json['table']) : null,
      items: json['items'] != null ? List.from(json['items']).map((x) => OrderItemEntity.fromJson(x)).toList() : [],
    );
  }
}

class OrderItemEntity {
  final int id;
  final int menuItemId;
  final int quantity;
  final double price;
  final double subtotal;
  final String menuItemName;
  final String menuItemImage;

  OrderItemEntity({
    required this.id,
    required this.menuItemId,
    required this.quantity,
    required this.price,
    required this.subtotal,
    required this.menuItemName,
    required this.menuItemImage,
  });

  factory OrderItemEntity.fromJson(Map<String, dynamic> json) {
    // Dig into the nested 'menu_item' object from your JSON
    final menu = json['menu_item'] ?? {};

    return OrderItemEntity(
      id: json['id'],
      menuItemId: json['menu_item_id'],
      quantity: json['quantity'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      subtotal: double.tryParse(json['subtotal'].toString()) ?? 0.0,
      // Map name and image from the nested object
      menuItemName: menu['name'] ?? 'Unknown Item',
      menuItemImage: menu['image_url'] ?? '',
    );
  }
}
