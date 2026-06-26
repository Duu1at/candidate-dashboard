import 'package:candidate_dashboard/data/data.dart';

abstract interface class CandidateRepository {
  Future<CandidatesPage> getCandidates(GetCandidatesParams params);

  Future<CandidateModel?> getById(String id);

  Future<void> updateStatus(UpdateStatusParams params);

  Stream<List<CandidateModel>> get candidatesStream;

  bool get isOffline;
}
