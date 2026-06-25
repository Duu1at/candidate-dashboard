import 'package:injectable/injectable.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

@LazySingleton(as: RemoteDatasource)
final class RemoteDatasourceImpl implements RemoteDatasource {
  const RemoteDatasourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<CandidateModel>> getCandidates() {
    return _apiClient.getListOfType(
      '/candidates',
      fromJson: CandidateModel.fromJson,
    );
  }

  @override
  Future<void> updateStatus(String id, String status) {
    return _apiClient.patch<void>(
      '/candidates/$id/status',
      data: {'status': status},
    );
  }
}
