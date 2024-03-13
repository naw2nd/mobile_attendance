abstract class LocalStorage {
  Future store({required String key, required dynamic value});
  Future fetch({required String key});
  Future remove({required String key});
}
