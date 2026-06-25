import 'package:candidate_dashboard/data/data.dart';

abstract interface class RemoteDatasource {
  Future<List<CandidateModel>> getCandidates();
  Future<void> updateStatus(String id, String status);
}
