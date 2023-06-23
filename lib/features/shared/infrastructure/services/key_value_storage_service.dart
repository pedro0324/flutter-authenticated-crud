abstract class KeyValueStorageService {

  Future<void> setValueKey<T>(String key, T value);
  Future<T?> getValue<T>(String key);// se recibe y se envia un valor generico
  Future<bool> removeKey(String key);
}
