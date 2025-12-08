import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/core/utils/form/validator_utils.dart';
import 'package:bukuku_frontend/features/table/data/request/update_table_request.dart';
import 'package:bukuku_frontend/features/table/domain/entity/table_entity.dart';
import 'package:bukuku_frontend/features/table/domain/repository/table_repository.dart';
import 'package:bukuku_frontend/features/table/presentation/list/controller/table_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableEditController extends GetxController {
  TableEditController(this.tableRepository);

  final TableRepository tableRepository;

  late final TableEntity table;

  final TextEditingController nameController = TextEditingController();
  final RxnString nameError = RxnString();

  final TextEditingController statusController = TextEditingController();
  final RxnString statusError = RxnString();

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is TableEntity) {
      table = Get.arguments;
      nameController.text = table.name;
      statusController.text = table.status.name;
    }
  }

  bool validateForm() {
    nameError.value = ValidatorUtils.required(nameController.text);
    return nameError.value == null;
  }

  void onSubmit() async {
    if (!validateForm()) return;

    isLoading.toggle();

    final res = await tableRepository.updateTable(
      UpdateTableRequest(
        id: table.id,
        name: nameController.text.trim(),
        status: TableStatus.fromJson(statusController.text),
      ),
    );

    res.fold(
      (e) {
        isLoading.toggle();
        ToasterUtils.showError(message: e.message);
      },
      (r) {
        isLoading.toggle();

        if (Get.isRegistered<TableController>()) {
          Get.find<TableController>().fetchTables();
        }

        Get.back();
        ToasterUtils.showSuccess(message: "Table updated successfully");
      },
    );
  }
}
