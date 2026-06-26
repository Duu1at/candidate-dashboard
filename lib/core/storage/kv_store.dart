typedef KVFromJson<T> = T Function(Map<String, dynamic> json);
typedef KVToJson<T> = Map<String, dynamic> Function(T value);

abstract interface class KVStore {
  Future<T?> readObject<T>(
    String key, {
    required KVFromJson<T> fromJson,
  });

  Future<List<T>?> readList<T>(
    String key, {
    required KVFromJson<T> fromJson,
  });

  Future<void> writeObject<T>(
    String key,
    T value, {
    required KVToJson<T> toJson,
  });

  Future<void> writeList<T>(
    String key,
    List<T> values, {
    required KVToJson<T> toJson,
  });

  Future<void> delete(String key);
}
