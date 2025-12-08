import 'package:bukuku_frontend/features/category/domain/entity/category.dart';

enum MenuItemStatus {
  active,
  disabled
  ;

  String toJson() => name;

  static MenuItemStatus fromBoolean(bool value) {
    return value ? active : disabled;
  }

  static MenuItemStatus fromString(String value) {
    return active.name.toLowerCase() == value.toLowerCase() ? active : disabled;
  }

  bool toBoolean() {
    return this == active;
  }
}

class MenuItemEntity {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  final double price;
  final String image;
  final String imageUrl;
  final MenuItemStatus status;

  final String? categoryName;
  final CategoryEntity? category;

  const MenuItemEntity({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.price,
    required this.image,
    required this.imageUrl,
    required this.status,
    this.categoryName,
    this.category,
  });

  factory MenuItemEntity.fromJson(Map<String, dynamic> json) {
    return MenuItemEntity(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price']),
      image: json['image'],
      imageUrl: json['image_url'],
      status: MenuItemStatus.fromBoolean(json['is_active'] ?? false),
      categoryName: json['category']?['name'],
      category: json['category'] != null ? CategoryEntity.fromJson(json['category']) : null,
    );
  }
}
