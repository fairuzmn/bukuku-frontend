import 'package:bukuku_frontend/features/table/presentation/add/binding/table_add_binding.dart';
import 'package:bukuku_frontend/features/table/presentation/add/view/table_add_view.dart';
import 'package:bukuku_frontend/features/table/presentation/edit/binding/table_edit_binding.dart';
import 'package:bukuku_frontend/features/table/presentation/edit/view/table_edit_view.dart';
import 'package:bukuku_frontend/features/table/presentation/list/binding/table_binding.dart';
import 'package:bukuku_frontend/features/table/presentation/list/view/table_list_view.dart';
import 'package:get/get.dart';
import '../app_links.dart';

class TableRoutes {
  static final pages = [
    GetPage(name: AppLinks.tableList, page: () => const TableListView(), binding: TableBinding()),
    GetPage(name: AppLinks.tableAdd, page: () => const TableAddView(), binding: TableAddBinding()),
    GetPage(name: AppLinks.tableEdit, page: () => const TableEditView(), binding: TableEditBinding()),
  ];
}
