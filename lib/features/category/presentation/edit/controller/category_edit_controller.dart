import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/core/utils/form/validator_utils.dart';
import 'package:bukuku_frontend/features/category/data/request/update_category_request.dart';
import 'package:bukuku_frontend/features/category/domain/entity/category.dart';
import 'package:bukuku_frontend/features/category/domain/respository/category_repository.dart';
import 'package:bukuku_frontend/features/category/presentation/list/controller/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryEditController extends GetxController {
  CategoryEditController(this.categoryRepository);

  final CategoryRepository categoryRepository;

  // Data passed from the List View
  late final CategoryEntity category;

  final TextEditingController nameController = TextEditingController();
  final RxnString nameError = RxnString();

  final TextEditingController descController = TextEditingController();
  final RxnString descError = RxnString();

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Retrieve the category object passed via arguments
    if (Get.arguments is CategoryEntity) {
      category = Get.arguments;
      // Pre-fill the controllers
      nameController.text = category.name;
      descController.text = category.description;
    }
  }

  bool validateForm() {
    nameError.value = ValidatorUtils.required(nameController.text);
    descError.value = ValidatorUtils.required(descController.text);

    return nameError.value == null && descError.value == null;
  }

  void onSubmit() async {
    if (!validateForm()) return;

    isLoading.toggle();

    final res = await categoryRepository.updateCategory(
      UpdateCategoryRequest(
        id: category.id,
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
        ToasterUtils.showSuccess(message: "Category updated successfully");
      },
    );
  }
}
