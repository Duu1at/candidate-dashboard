import 'package:candidate_dashboard/data/data.dart';

abstract interface class LocalDatasource {
  Future<List<CandidateModel>?> getCachedCandidates();

  Future<void> cacheCandidates(List<CandidateModel> candidates);

  Future<Map<String, String>> getLocalStatuses();

  Future<void> saveLocalStatus(String id, String status);

  Future<void> clearCache();

  Future<Map<String, String>> getPendingQueue();

  Future<void> addToPendingQueue(String id, String status);

  Future<void> removeFromPendingQueue(String id);
}
