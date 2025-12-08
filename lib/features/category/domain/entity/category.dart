import 'package:bukuku_frontend/core/network/rest_response.dart';

class CategoryEntity {
  final int id;
  final String name;
  final String description;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.description,
  });

  factory CategoryEntity.fromJson(JsonMap json) {
    return CategoryEntity(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
