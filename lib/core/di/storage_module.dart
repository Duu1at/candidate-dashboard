import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'package:candidate_dashboard/core/storage/storage.dart';

@module
abstract class StorageModule {
  @Named('candidates_kv')
  @lazySingleton
  KVStore candidatesKVStore() => HiveKVStore(Hive.box<String>('candidates'));

  @Named('statuses_kv')
  @lazySingleton
  KVStore statusesKVStore() => HiveKVStore(Hive.box<String>('statuses'));
}
