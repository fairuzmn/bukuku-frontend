import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/category/data/request/create_category_request.dart';
import 'package:bukuku_frontend/features/category/data/request/update_category_request.dart';
import 'package:bukuku_frontend/features/category/data/response/categories_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class CategoryRepository {
  Future<Either<Failure, RestResponse<CategoriesResponse>>> getAllCategories();

  Future<Either<Failure, RestResponse>> createCategory(CreateCategoryRequest request);

  Future<Either<Failure, RestResponse>> updateCategory(UpdateCategoryRequest request);

  Future<Either<Failure, RestResponse>> deleteCategory(int id);
}
