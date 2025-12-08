import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/core/utils/form/validator_utils.dart';
import 'package:bukuku_frontend/features/category/domain/entity/category.dart';
import 'package:bukuku_frontend/features/category/domain/respository/category_repository.dart';
import 'package:bukuku_frontend/features/menu_item/data/request/create_menu_item_request.dart';
import 'package:bukuku_frontend/features/menu_item/domain/entity/menu_item_entity.dart';
import 'package:bukuku_frontend/features/menu_item/domain/repository/menu_item_repository.dart';
import 'package:bukuku_frontend/features/menu_item/presentation/list/controller/menu_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MenuItemAddController extends GetxController {
  MenuItemAddController(this.menuItemRepository, this.categoryRepository);

  final MenuItemRepository menuItemRepository;
  final CategoryRepository categoryRepository;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  final RxnString nameError = RxnString();
  final RxnString descError = RxnString();
  final RxnString priceError = RxnString();
  final RxnString statusError = RxnString();
  final RxnString categoryError = RxnString();

  final RxBool isLoading = false.obs;

  final Rxn<XFile> selectedImage = Rxn();

  // Category Dropdown Logic
  final RxList<CategoryEntity> categories = RxList([]);

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() async {
    final res = await categoryRepository.getAllCategories();
    res.fold(
      (e) => ToasterUtils.showError(message: "Failed to load categories"),
      (r) => categories.value = r.data?.categories ?? [],
    );
  }

  void choseImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) selectedImage.value = image;
  }

  bool validateForm() {
    nameError.value = ValidatorUtils.required(nameController.text);
    descError.value = ValidatorUtils.required(descController.text);
    priceError.value = ValidatorUtils.required(priceController.text);
    statusError.value = ValidatorUtils.required(statusController.text);
    categoryError.value = ValidatorUtils.required(categoryController.text);

    if (selectedImage.value == null) {
      ToasterUtils.showError(message: "Select image");
      return false;
    }

    return nameError.value == null &&
        descError.value == null &&
        priceError.value == null &&
        statusError.value == null &&
        categoryError.value == null;
  }

  void onSubmit() async {
    if (!validateForm()) return;

    isLoading.toggle();

    final res = await menuItemRepository.createMenuItem(
      CreateMenuItemRequest(
        categoryId: categories.firstWhereOrNull((cat) => cat.name == categoryController.text)?.id ?? 0,
        name: nameController.text.trim(),
        description: descController.text.trim(),
        price: double.tryParse(priceController.text) ?? 0,
        image: selectedImage.value?.path ?? "",
        isActive: MenuItemStatus.fromString(statusController.text).toBoolean(),
      ),
    );

    res.fold(
      (e) {
        isLoading.toggle();
        ToasterUtils.showError(message: e.message);
      },
      (r) {
        isLoading.toggle();
        if (Get.isRegistered<MenuItemController>()) {
          Get.find<MenuItemController>().fetchMenuItems();
        }
        Get.back();
        ToasterUtils.showSuccess(message: "Menu Item added successfully");
      },
    );
  }
}
