import '../../domain/entity/menu_item_entity.dart';

class MenuItemsResponse {
  final List<MenuItemEntity> items;

  const MenuItemsResponse({required this.items});

  factory MenuItemsResponse.fromJson(Map<String, dynamic> json) {
    return MenuItemsResponse(
      items: List.from(json['items']).map((x) => MenuItemEntity.fromJson(x)).toList(),
    );
  }
}
