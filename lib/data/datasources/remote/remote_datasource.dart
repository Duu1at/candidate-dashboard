import '../../models/candidate.dart';

abstract interface class RemoteDatasource {
  Future<List<Candidate>> getCandidates();
  Future<void> updateStatus(String id, String status);
}
