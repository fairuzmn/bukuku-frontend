import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/category/domain/entity/category.dart';

class CategoriesResponse {
  final List<CategoryEntity> categories;

  const CategoriesResponse({
    required this.categories,
  });

  factory CategoriesResponse.fromJson(JsonMap json) {
    return CategoriesResponse(
      categories: List.from(json['categories']).map((json) => CategoryEntity.fromJson(json)).toList(),
    );
  }
}
