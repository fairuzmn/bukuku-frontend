import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/dio_client.dart';
import 'package:bukuku_frontend/core/network/endpoints.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/menu_item/data/request/create_menu_item_request.dart';
import 'package:bukuku_frontend/features/menu_item/data/request/update_menu_item_request.dart';
import 'package:bukuku_frontend/features/menu_item/data/response/menu_items_response.dart';
import 'package:bukuku_frontend/features/menu_item/domain/repository/menu_item_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

class MenuItemRepositoryImpl implements MenuItemRepository {
  final DioClient dioClient;

  const MenuItemRepositoryImpl(this.dioClient);

  @override
  Future<Either<Failure, RestResponse<MenuItemsResponse>>> getAllMenuItems() async {
    try {
      final res = await dioClient.getRequest(
        Endpoints.menuItems,
        decoder: (json) => MenuItemsResponse.fromJson(json),
      );
      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse>> createMenuItem(CreateMenuItemRequest request) async {
    try {
      final formData = FormData.fromMap({
        'category_id': request.categoryId,
        'name': request.name,
        'description': request.description,
        'price': request.price,
        'is_active': request.isActive ? 1 : 0,
        'image': await MultipartFile.fromFile(
          request.image,
          filename: request.image.split('/').last,
        ),
      });

      // 3. Send as FormData
      // Assuming your DioClient passes 'body' to dio.post(data: body)
      final res = await dioClient.postRequest(
        Endpoints.menuItems,
        body: formData,
        decoder: (json) => {},
      );
      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse>> updateMenuItem(UpdateMenuItemRequest request) async {
    try {
      final Map<String, dynamic> map = {
        '_method': 'PATCH',
        'category_id': request.categoryId,
        'name': request.name,
        'description': request.description,
        'price': request.price,
        'is_active': request.isActive ? 1 : 0,
      };

      if (request.image != null && request.image!.isNotEmpty) {
        map['image'] = await MultipartFile.fromFile(
          request.image!,
          filename: request.image!.split('/').last,
        );
      }

      final formData = FormData.fromMap(map);

      final res = await dioClient.postRequest(
        "${Endpoints.menuItems}/${request.id}",
        body: formData,
        decoder: (json) => null,
      );
      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }

  @override
  Future<Either<Failure, RestResponse>> deleteMenuItem(int id) async {
    try {
      final res = await dioClient.deleteRequest(
        "${Endpoints.menuItems}/$id",
        decoder: (json) => null,
      );
      return Right(res);
    } catch (e) {
      return Left(Failure.message(e.toString()));
    }
  }
}
