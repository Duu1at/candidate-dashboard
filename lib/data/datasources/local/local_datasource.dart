import 'package:candidate_dashboard/data/data.dart';

abstract interface class LocalDatasource {
  Future<List<CandidateModel>?> getCachedCandidates();

  Future<void> cacheCandidates(List<CandidateModel> candidates);

  Future<Map<String, String>> getLocalStatuses();

  Future<void> saveLocalStatus(String id, String status);

  Future<void> clearCache();
}
