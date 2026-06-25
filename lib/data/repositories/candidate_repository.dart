import 'package:candidate_dashboard/data/data.dart';

abstract interface class CandidateRepository {
  Future<List<CandidateModel>> getCandidates({bool forceRefresh = false});
  Future<CandidateModel?> getById(String id);
  Future<void> updateStatus(String id, String status);
  Stream<List<CandidateModel>> get candidatesStream;
  bool get isOffline;
}
