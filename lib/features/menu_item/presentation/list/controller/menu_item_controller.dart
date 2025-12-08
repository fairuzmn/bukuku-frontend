import 'package:bukuku_frontend/core/utils/alert/dialog_utils.dart';
import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/features/menu_item/domain/entity/menu_item_entity.dart';
import 'package:bukuku_frontend/features/menu_item/domain/repository/menu_item_repository.dart';
import 'package:bukuku_frontend/routes/app_links.dart';
import 'package:get/get.dart';

class MenuItemController extends GetxController {
  MenuItemController(this.menuItemRepository);

  final MenuItemRepository menuItemRepository;

  final RxBool isLoading = false.obs;
  final RxList<MenuItemEntity> items = RxList([]);

  @override
  void onReady() {
    super.onReady();
    fetchMenuItems();
  }

  void fetchMenuItems() async {
    isLoading.toggle();

    var res = await menuItemRepository.getAllMenuItems();
    res.fold(
      (e) => ToasterUtils.showError(message: e.message),
      (r) => items.value = r.data?.items ?? [],
    );

    isLoading.toggle();
  }

  void add() {
    Get.toNamed(AppLinks.menuItemAdd);
  }

  void edit(MenuItemEntity item) {
    Get.toNamed(AppLinks.menuItemEdit, arguments: item);
  }

  void delete(MenuItemEntity item) {
    AppDialogUtils.confirmDeleteDialog(
      title: "Delete Menu Item",
      desc: "Are you sure you want to remove ${item.name}?",
      onConfirm: () => _deleteItemApi(item.id),
    );
  }

  void _deleteItemApi(int id) async {
    isLoading.toggle();
    final res = await menuItemRepository.deleteMenuItem(id);

    res.fold(
      (e) {
        isLoading.toggle();
        ToasterUtils.showError(message: e.message);
      },
      (r) {
        isLoading.toggle();
        fetchMenuItems();
      },
    );
  }
}
