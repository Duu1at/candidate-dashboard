import '../../models/candidate.dart';

abstract class RemoteDatasource {
  Future<List<Candidate>> getCandidates();
  Future<void> updateStatus(String id, String status);
}
