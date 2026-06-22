import '../../models/candidate.dart';

abstract class LocalDatasource {
  Future<List<Candidate>?> getCachedCandidates();
  Future<void> cacheCandidates(List<Candidate> candidates);
  Future<Map<String, String>> getLocalStatuses();
  Future<void> saveLocalStatus(String id, String status);
  Future<void> clearCache();
}
