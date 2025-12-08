import 'package:bukuku_frontend/features/menu_item/presentation/add/binding/menu_item_add_binding.dart';
import 'package:bukuku_frontend/features/menu_item/presentation/add/view/menu_item_add_view.dart';
import 'package:bukuku_frontend/features/menu_item/presentation/edit/binding/menu_item_edit_binding.dart';
import 'package:bukuku_frontend/features/menu_item/presentation/edit/view/menu_item_edit_view.dart';
import 'package:bukuku_frontend/features/menu_item/presentation/list/binding/menu_item_binding.dart';
import 'package:bukuku_frontend/features/menu_item/presentation/list/view/menu_item_list_view.dart';
import 'package:get/get.dart';
import '../app_links.dart';

class MenuItemRoutes {
  static final pages = [
    GetPage(name: AppLinks.menuItemList, page: () => const MenuItemListView(), binding: MenuItemBinding()),
    GetPage(name: AppLinks.menuItemAdd, page: () => const MenuItemAddView(), binding: MenuItemAddBinding()),
    GetPage(name: AppLinks.menuItemEdit, page: () => const MenuItemEditView(), binding: MenuItemEditBinding()),
  ];
}
