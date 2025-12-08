class CreateMenuItemRequest {
  final int categoryId;
  final String name;
  final String? description;
  final double price;
  final String image;
  final bool isActive;

  CreateMenuItemRequest({
    required this.categoryId,
    required this.name,
    this.description,
    required this.price,
    required this.image,
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'is_active': isActive,
    };
  }
}
