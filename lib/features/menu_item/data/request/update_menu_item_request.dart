class UpdateMenuItemRequest {
  final int id;
  final int categoryId;
  final String name;
  final String? description;
  final double price;
  final bool isActive;
  final String? image;

  UpdateMenuItemRequest({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    required this.price,
    required this.isActive,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'is_active': isActive,
      'image': image,
    };
  }
}
