import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/core/utils/form/validator_utils.dart';
import 'package:bukuku_frontend/features/table/data/request/create_table_request.dart';
import 'package:bukuku_frontend/features/table/domain/entity/table_entity.dart';
import 'package:bukuku_frontend/features/table/domain/repository/table_repository.dart';
import 'package:bukuku_frontend/features/table/presentation/list/controller/table_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableAddController extends GetxController {
  TableAddController(this.tableRepository);

  final TableRepository tableRepository;

  final TextEditingController nameController = TextEditingController();
  final RxnString nameError = RxnString();

  final TextEditingController statusController = TextEditingController();
  final RxnString statusError = RxnString();


  final RxBool isLoading = false.obs;

  bool validateForm() {
    nameError.value = ValidatorUtils.required(nameController.text);
    return nameError.value == null;
  }

  void onSubmit() async {
    if (!validateForm()) return;

    isLoading.toggle();

    final res = await tableRepository.createTable(
      CreateTableRequest(
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
        ToasterUtils.showSuccess(message: "Table added successfully");
      },
    );
  }
}
