import 'package:injectable/injectable.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

const _kCandidatesKey = 'candidates_list';
const _kStatusesKey = 'statuses_map';
const _kPendingQueueKey = 'pending_status_queue';

@LazySingleton(as: LocalDatasource)
final class LocalDatasourceImpl implements LocalDatasource {
  const LocalDatasourceImpl(
    @Named('candidates_kv') this._candidates,
    @Named('statuses_kv') this._statuses,
  );

  final KVStore _candidates;
  final KVStore _statuses;

  @override
  Future<List<CandidateModel>?> getCachedCandidates() {
    return _candidates.readList(
      _kCandidatesKey,
      fromJson: CandidateModel.fromJson,
    );
  }

  @override
  Future<void> cacheCandidates(List<CandidateModel> candidates) {
    return _candidates.writeList(
      _kCandidatesKey,
      candidates,
      toJson: (c) => c.toJson(),
    );
  }

  @override
  Future<Map<String, String>> getLocalStatuses() async {
    final result = await _statuses.readObject(
      _kStatusesKey,
      fromJson: (json) => json.map(
        (k, v) => MapEntry(k, v as String),
      ),
    );
    return result ?? {};
  }

  @override
  Future<void> saveLocalStatus(String id, String status) async {
    final statuses = await getLocalStatuses();
    statuses[id] = status;
    await _statuses.writeObject<Map<String, String>>(
      _kStatusesKey,
      statuses,
      toJson: Map<String, dynamic>.from,
    );
  }

  @override
  Future<void> clearCache() {
    return _candidates.delete(_kCandidatesKey);
  }

  @override
  Future<Map<String, String>> getPendingQueue() async {
    final result = await _statuses.readObject(
      _kPendingQueueKey,
      fromJson: (json) => json.map((k, v) => MapEntry(k, v as String)),
    );
    return result ?? {};
  }

  @override
  Future<void> addToPendingQueue(String id, String status) async {
    final queue = await getPendingQueue();
    queue[id] = status;
    await _statuses.writeObject<Map<String, String>>(
      _kPendingQueueKey,
      queue,
      toJson: Map<String, dynamic>.from,
    );
  }

  @override
  Future<void> removeFromPendingQueue(String id) async {
    final queue = await getPendingQueue();
    queue.remove(id);
    await _statuses.writeObject<Map<String, String>>(
      _kPendingQueueKey,
      queue,
      toJson: Map<String, dynamic>.from,
    );
  }
}
