import 'package:candidate_dashboard/data/data.dart';

abstract interface class RemoteDatasource {
  Future<CandidatesPage> getCandidates({
    required int page,
    required int limit,
    String search,
    String? filter,
    String sort,
  });
  Future<CandidateModel?> getById(String id);
  Future<void> updateStatus(String id, String status);
}
