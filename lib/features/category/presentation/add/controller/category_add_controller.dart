import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/core/utils/form/validator_utils.dart';
import 'package:bukuku_frontend/features/category/data/request/create_category_request.dart';
import 'package:bukuku_frontend/features/category/domain/respository/category_repository.dart';
import 'package:bukuku_frontend/features/category/presentation/list/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryAddController extends GetxController {
  CategoryAddController(this.categoryRepository);

  final CategoryRepository categoryRepository;

  final TextEditingController nameController = TextEditingController();
  final RxnString nameError = RxnString();

  final TextEditingController descController = TextEditingController();
  final RxnString descError = RxnString();

  final RxBool isLoading = false.obs;

  bool validateForm() {
    nameError.value = ValidatorUtils.required(nameController.text);
    descError.value = ValidatorUtils.required(descController.text);

    return nameError.value == null && descError.value == null;
  }

  void onSubmit() async {
    if (!validateForm()) return;

    isLoading.toggle();

    final res = await categoryRepository.createCategory(
      CreateCategoryRequest(
        name: nameController.text.trim(),
        description: descController.text.trim(),
      ),
    );

    res.fold(
      (e) {
        isLoading.toggle();
        ToasterUtils.showError(message: e.message);
      },
      (r) {
        isLoading.toggle();

        if (Get.isRegistered<CategoryController>()) {
          Get.find<CategoryController>().fetchCategory();
        }

        Get.back();
        ToasterUtils.showSuccess(message: "Category added successfully");
      },
    );
  }
}
