import 'package:candidate_dashboard/data/data.dart';

abstract interface class CandidateRepository {
  Future<List<Candidate>> getCandidates({bool forceRefresh = false});
  Future<Candidate?> getById(String id);
  Future<void> updateStatus(String id, String status);
  Stream<List<Candidate>> get candidatesStream;
  bool get isOffline;
}
