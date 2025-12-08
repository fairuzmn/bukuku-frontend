import 'package:bukuku_frontend/core/errors/failures.dart';
import 'package:bukuku_frontend/core/network/rest_response.dart';
import 'package:bukuku_frontend/features/menu_item/data/request/create_menu_item_request.dart';
import 'package:bukuku_frontend/features/menu_item/data/request/update_menu_item_request.dart';
import 'package:bukuku_frontend/features/menu_item/data/response/menu_items_response.dart';
import 'package:fpdart/fpdart.dart';

abstract class MenuItemRepository {
  Future<Either<Failure, RestResponse<MenuItemsResponse>>> getAllMenuItems();

  Future<Either<Failure, RestResponse>> createMenuItem(CreateMenuItemRequest request);

  Future<Either<Failure, RestResponse>> updateMenuItem(UpdateMenuItemRequest request);

  Future<Either<Failure, RestResponse>> deleteMenuItem(int id);
}
