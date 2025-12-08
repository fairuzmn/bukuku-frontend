import 'package:bukuku_frontend/features/category/presentation/add/binding/category_add_binding.dart';
import 'package:bukuku_frontend/features/category/presentation/add/view/category_add_view.dart';
import 'package:bukuku_frontend/features/category/presentation/edit/binding/category_add_binding.dart';
import 'package:bukuku_frontend/features/category/presentation/edit/view/category_edit_view.dart';
import 'package:bukuku_frontend/features/category/presentation/list/binding/category_binding.dart';
import 'package:bukuku_frontend/features/category/presentation/list/view/category_list_view.dart';
import 'package:get/get.dart';
import '../app_links.dart';

class CategoryRoutes {
  static final pages = [
    GetPage(name: AppLinks.categoryList, page: () => const CategoryListView(), binding: CategoryBinding()),
    GetPage(name: AppLinks.categoryAdd, page: () => const CategoryAddView(), binding: CategoryAddBinding()),
    GetPage(name: AppLinks.categoryEdit, page: () => const CategoryEditView(), binding: CategoryEditBinding()),
  ];
}
