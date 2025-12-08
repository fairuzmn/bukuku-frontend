import 'dart:convert';

import 'package:bukuku_frontend/core/constant/storage_constant.dart';
import 'package:bukuku_frontend/core/platform/storage/local_storage.dart';
import 'package:bukuku_frontend/features/auth/domain/entity/user.dart';
import 'package:get/get.dart';

class SessionController extends GetxController {
  SessionController(this.localStorage);

  final LocalStorage localStorage;

  final Rxn<UserEntity> user = Rxn();

  void setNewUser(UserEntity newUser) async {
    user.value = newUser;

    await localStorage.write(value: jsonEncode(newUser.toJson()), key: StorageConstant.authSession);
  }

  Future<UserEntity?> initLocalUser() async {
    var findUser = await localStorage.read(key: StorageConstant.authSession);

    if (findUser == null) return null;

    var localUser = UserEntity.fromJson(jsonDecode(findUser));
    user.value = localUser;

    return localUser;
  }
}
