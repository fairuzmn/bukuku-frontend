import 'package:bukuku_frontend/core/platform/storage/local_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageImpl implements LocalStorage {
  final FlutterSecureStorage _storage;

  LocalStorageImpl(this._storage);

  @override
  Future<String?> read({required String key}) {
    return _storage.read(key: key);
  }

  @override
  Future<void> write({required dynamic value, required String key}) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<void> delete({required String key}) {
    return _storage.delete(key: key);
  }
}
