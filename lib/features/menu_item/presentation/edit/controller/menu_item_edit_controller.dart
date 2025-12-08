import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/core/utils/form/validator_utils.dart';
import 'package:bukuku_frontend/features/category/domain/entity/category.dart';
import 'package:bukuku_frontend/features/category/domain/respository/category_repository.dart';
import 'package:bukuku_frontend/features/menu_item/data/request/update_menu_item_request.dart';
import 'package:bukuku_frontend/features/menu_item/domain/entity/menu_item_entity.dart';
import 'package:bukuku_frontend/features/menu_item/domain/repository/menu_item_repository.dart';
import 'package:bukuku_frontend/features/menu_item/presentation/list/controller/menu_item_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MenuItemEditController extends GetxController {
  MenuItemEditController(this.menuItemRepository, this.categoryRepository);

  final MenuItemRepository menuItemRepository;
  final CategoryRepository categoryRepository;

  late final MenuItemEntity item;

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

  final RxString currentImage = RxString("");

  final RxBool isLoading = false.obs;

  // Added Image Picker State
  final Rxn<XFile> selectedImage = Rxn();

  final RxList<CategoryEntity> categories = RxList([]);

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is MenuItemEntity) {
      item = Get.arguments;
      _initializeData();
    }
  }

  void _initializeData() async {
    nameController.text = item.name;
    descController.text = item.description ?? '';
    priceController.text = item.price.toInt().toString();
    statusController.text = item.status.name;
    currentImage.value = item.imageUrl;

    // 2. Fetch categories to populate dropdown
    final res = await categoryRepository.getAllCategories();
    res.fold(
      (e) => ToasterUtils.showError(message: "Failed to load categories"),
      (r) {
        categories.value = r.data?.categories ?? [];

        // 3. Set the selected category name based on ID
        categoryController.text = categories.firstWhereOrNull((cat) => cat.id == item.categoryId)?.name ?? "";
      },
    );
  }

  // Added Image Picker Function
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

    return nameError.value == null &&
        descError.value == null &&
        priceError.value == null &&
        statusError.value == null &&
        categoryError.value == null;
  }

  void onSubmit() async {
    if (!validateForm()) return;

    isLoading.toggle();

    // Check if a NEW image was selected
    String? imagePath;
    if (selectedImage.value != null) {
      imagePath = selectedImage.value!.path;
    }

    // Resolve Category ID
    final categoryId =
        categories.firstWhereOrNull((cat) => cat.name == categoryController.text)?.id ??
        item.categoryId; // Fallback to existing ID if lookup fails

    final res = await menuItemRepository.updateMenuItem(
      UpdateMenuItemRequest(
        id: item.id,
        categoryId: categoryId,
        name: nameController.text.trim(),
        description: descController.text.trim(),
        price: double.tryParse(priceController.text) ?? 0,
        isActive: MenuItemStatus.fromString(statusController.text).toBoolean(),
        image: imagePath, // Pass the path (null if no new image)
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
        ToasterUtils.showSuccess(message: "Menu Item updated successfully");
      },
    );
  }
}
