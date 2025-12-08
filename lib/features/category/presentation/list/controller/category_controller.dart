import 'package:bukuku_frontend/core/utils/alert/dialog_utils.dart';
import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/features/category/domain/entity/category.dart';
import 'package:bukuku_frontend/features/category/domain/respository/category_repository.dart';
import 'package:bukuku_frontend/routes/app_links.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  CategoryController(this.categoryRepository);

  final CategoryRepository categoryRepository;

  final RxBool isLoading = false.obs;
  final RxList<CategoryEntity> categories = RxList([]);

  @override
  void onReady() {
    super.onReady();
    fetchCategory();
  }

  void fetchCategory() async {
    isLoading.toggle();

    var res = await categoryRepository.getAllCategories();
    res.fold(
      (e) {
        ToasterUtils.showError(message: e.message);
      },
      (r) {
        categories.value = r.data?.categories ?? [];
      },
    );

    isLoading.toggle();
  }

  void add() {
    Get.toNamed(AppLinks.categoryAdd);
  }

  void edit(CategoryEntity category) {
    Get.toNamed(AppLinks.categoryEdit, arguments: category);
  }

  void delete(CategoryEntity category) {
    AppDialogUtils.confirmDeleteDialog(
      title: "Delete Category",
      desc: "Are you sure you want to remove ${category.name}?",
      onConfirm: () {
        _deleteCategoryApi(category.id);
      },
    );
  }

  void _deleteCategoryApi(int id) async {
    // 1. Show global loading or local loading
    isLoading.toggle();

    final res = await categoryRepository.deleteCategory(id);

    res.fold(
      (e) {
        isLoading.toggle();
        ToasterUtils.showError(message: e.message);
      },
      (r) {
        isLoading.toggle();

        // Refresh the list to reflect changes
        fetchCategory();
      },
    );
  }
}
