import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../models/candidate.dart';
import 'local_datasource.dart';

const _kCandidatesKey = 'candidates_list';
const _kStatusesKey = 'statuses_map';

@LazySingleton(as: LocalDatasource)
class LocalDatasourceImpl implements LocalDatasource {
  LocalDatasourceImpl(
    @Named('candidates_box') this._candidatesBox,
    @Named('statuses_box') this._statusesBox,
  );

  final Box<String> _candidatesBox;
  final Box<String> _statusesBox;

  @override
  Future<List<Candidate>?> getCachedCandidates() async {
    final raw = _candidatesBox.get(_kCandidatesKey);
    if (raw == null) return null;
    final list = jsonDecode(raw) as List<dynamic>;
    return list.map((e) => Candidate.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> cacheCandidates(List<Candidate> candidates) async {
    final json = jsonEncode(candidates.map((c) => c.toJson()).toList());
    await _candidatesBox.put(_kCandidatesKey, json);
  }

  @override
  Future<Map<String, String>> getLocalStatuses() async {
    final raw = _statusesBox.get(_kStatusesKey);
    if (raw == null) return {};
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return map.map((k, v) => MapEntry(k, v as String));
  }

  @override
  Future<void> saveLocalStatus(String id, String status) async {
    final statuses = await getLocalStatuses();
    statuses[id] = status;
    await _statusesBox.put(_kStatusesKey, jsonEncode(statuses));
  }

  @override
  Future<void> clearCache() async {
    await _candidatesBox.delete(_kCandidatesKey);
  }
}
