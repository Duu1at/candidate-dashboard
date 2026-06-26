import 'dart:convert';
import 'dart:developer';
import 'package:hive/hive.dart';
import 'kv_store.dart';

final class HiveKVStore implements KVStore {
  const HiveKVStore(this._box);

  final Box<String> _box;

  @override
  Future<T?> readObject<T>(
    String key, {
    required KVFromJson<T> fromJson,
  }) async {
    final raw = _box.get(key);
    if (raw == null) return null;
    try {
      return fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (e, s) {
      log(
        'HiveKVStore.readObject failed for key=$key',
        error: e,
        stackTrace: s,
      );
      return null;
    }
  }

  @override
  Future<List<T>?> readList<T>(
    String key, {
    required KVFromJson<T> fromJson,
  }) async {
    final raw = _box.get(key);
    if (raw == null) return null;
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list.map((e) => fromJson(e as Map<String, dynamic>)).toList();
    } catch (e, s) {
      log('HiveKVStore.readList failed for key=$key', error: e, stackTrace: s);
      return null;
    }
  }

  @override
  Future<void> writeObject<T>(
    String key,
    T value, {
    required KVToJson<T> toJson,
  }) {
    return _box.put(
      key,
      jsonEncode(toJson(value)),
    );
  }

  @override
  Future<void> writeList<T>(
    String key,
    List<T> values, {
    required KVToJson<T> toJson,
  }) async {
    return _box.put(
      key,
      jsonEncode(values.map(toJson).toList()),
    );
  }

  @override
  Future<void> delete(String key) {
    return _box.delete(key);
  }
}
