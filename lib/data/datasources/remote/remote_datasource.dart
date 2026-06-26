import 'package:candidate_dashboard/data/data.dart';

abstract interface class RemoteDatasource {
  Future<CandidatesPage> getCandidates(GetCandidatesParams params);

  Future<CandidateModel?> getById(String id);

  Future<void> updateStatus(UpdateStatusParams params);
}
