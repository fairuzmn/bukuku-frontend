import 'package:bukuku_frontend/core/utils/alert/dialog_utils.dart';
import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/features/table/domain/entity/table_entity.dart';
import 'package:bukuku_frontend/features/table/domain/repository/table_repository.dart';
import 'package:bukuku_frontend/routes/app_links.dart';
import 'package:get/get.dart';

class TableController extends GetxController {
  TableController(this.tableRepository);

  final TableRepository tableRepository;

  final RxBool isLoading = false.obs;
  final RxList<TableEntity> tables = RxList([]);

  @override
  void onReady() {
    super.onReady();
    fetchTables();
  }

  void fetchTables() async {
    isLoading.toggle();

    var res = await tableRepository.getAllTables();
    res.fold(
      (e) {
        ToasterUtils.showError(message: e.message);
      },
      (r) {
        tables.value = r.data?.tables ?? [];
      },
    );

    isLoading.toggle();
  }

  void add() {
    Get.toNamed(AppLinks.tableAdd);
  }

  void edit(TableEntity table) {
    Get.toNamed(AppLinks.tableEdit, arguments: table);
  }

  void delete(TableEntity table) {
    AppDialogUtils.confirmDeleteDialog(
      title: "Delete Table",
      desc: "Are you sure you want to remove ${table.name}?",
      onConfirm: () {
        _deleteTableApi(table.id);
      },
    );
  }

  void _deleteTableApi(int id) async {
    isLoading.toggle();

    final res = await tableRepository.deleteTable(id);

    res.fold(
      (e) {
        isLoading.toggle();
        ToasterUtils.showError(message: e.message);
      },
      (r) {
        isLoading.toggle();
        fetchTables();
      },
    );
  }
}
