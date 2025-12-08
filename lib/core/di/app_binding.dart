import 'package:bukuku_frontend/core/config/app_config.dart';
import 'package:bukuku_frontend/core/env/app_env.dart';
import 'package:bukuku_frontend/core/network/dio_client.dart';
import 'package:bukuku_frontend/core/platform/device_info/device_info.dart';
import 'package:bukuku_frontend/core/platform/storage/local_storage.dart';
import 'package:bukuku_frontend/core/platform/storage/local_storage_impl.dart';
import 'package:bukuku_frontend/core/session/session_controller.dart';
import 'package:bukuku_frontend/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bukuku_frontend/features/auth/domain/respository/auth_repository.dart';
import 'package:bukuku_frontend/features/category/data/repository/category_repository_impl.dart';
import 'package:bukuku_frontend/features/category/domain/respository/category_repository.dart';
import 'package:bukuku_frontend/features/kitchen/data/repository/kitchen_repository_impl.dart';
import 'package:bukuku_frontend/features/kitchen/domain/repository/kitchen_repository.dart';
import 'package:bukuku_frontend/features/menu_item/data/repository/menu_item_repository_impl.dart';
import 'package:bukuku_frontend/features/menu_item/domain/repository/menu_item_repository.dart';
import 'package:bukuku_frontend/features/order/data/repository/order_repository_impl.dart';
import 'package:bukuku_frontend/features/order/domain/repository/order_repository.dart';
import 'package:bukuku_frontend/features/table/data/repository/table_repository_impl.dart';
import 'package:bukuku_frontend/features/table/domain/repository/table_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings {
  AppBindings({
    required this.env,
  });

  final AppEnv env;

  @override
  Future<void> dependencies() async {
    Get.put<AppConfig>(AppConfig(env: env));
    await Get.putAsync<DeviceInfo>(() async {
      final d = DeviceInfo();
      await d.init();
      return d;
    });

    Get.put<FlutterSecureStorage>(FlutterSecureStorage());
    Get.put<LocalStorage>(LocalStorageImpl(Get.find()));

    Get.put<SessionController>(SessionController(Get.find()));
    Get.put<DioClient>(DioClient(appConfig: Get.find()));

    // Repositories
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()), fenix: true);
    Get.lazyPut<CategoryRepository>(() => CategoryRepositoryImpl(Get.find()), fenix: true);
    Get.lazyPut<TableRepository>(() => TableRepositoryImpl(Get.find()), fenix: true);
    Get.lazyPut<MenuItemRepository>(() => MenuItemRepositoryImpl(Get.find()), fenix: true);
    Get.lazyPut<OrderRepository>(() => OrderRepositoryImpl(Get.find()), fenix: true);
    Get.lazyPut<KitchenRepository>(() => KitchenRepositoryImpl(Get.find()), fenix: true);
  }
}
