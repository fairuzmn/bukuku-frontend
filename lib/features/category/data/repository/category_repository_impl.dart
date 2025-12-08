import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/dio_client.dart';
import 'package:bukuku_frontend/core/network/endpoints.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/category/data/request/create_category_request.dart';
import 'package:bukuku_frontend/features/category/data/request/update_category_request.dart';
import 'package:bukuku_frontend/features/category/data/response/categories_response.dart';
import 'package:bukuku_frontend/features/category/domain/respository/category_repository.dart';
import 'package:fpdart/fpdart.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final DioClient dioClient;

  const CategoryRepositoryImpl(this.dioClient);

  @override
  Future<Either<Failure, RestResponse<CategoriesResponse>>> getAllCategories() async {
    try {
      final res = await dioClient.getRequest(
        Endpoints.categories,
        decoder: (json) => CategoriesResponse.fromJson(json),
      );

      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse<dynamic>>> createCategory(CreateCategoryRequest request) async {
    try {
      final res = await dioClient.postRequest(
        Endpoints.categories,
        body: request.toJson(),
        decoder: (json) => {},
      );

      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse>> updateCategory(UpdateCategoryRequest request) async {
    try {
      final res = await dioClient.patchRequest(
        "${Endpoints.categories}/${request.id}",
        body: request.toJson(),
        decoder: (json) => null,
      );

      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse>> deleteCategory(int id) async {
    try {
      final res = await dioClient.deleteRequest(
        "${Endpoints.categories}/$id",
        decoder: (json) => null,
      );

      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }
}
