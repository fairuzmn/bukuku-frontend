class UpdateCategoryRequest {
  final int id;
  final String name;
  final String description;

  UpdateCategoryRequest({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}