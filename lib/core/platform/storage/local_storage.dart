abstract class LocalStorage {
  Future<void> write({required dynamic value, required String key});

  Future<String?> read({required String key});

  Future<void> delete({required String key});
}
