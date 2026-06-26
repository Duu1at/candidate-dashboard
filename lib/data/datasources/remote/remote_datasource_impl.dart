import 'package:injectable/injectable.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

@LazySingleton(as: RemoteDatasource)
final class RemoteDatasourceImpl implements RemoteDatasource {
  const RemoteDatasourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<CandidatesPage> getCandidates(GetCandidatesParams params) {
    return _apiClient.getType(
      '/candidates',
      fromJson: CandidatesPage.fromJson,
      params: GetApiParams(
        queryParameters: {
          'page': params.page,
          'limit': params.limit,
          if (params.search.isNotEmpty) 'search': params.search,
          'filter': ?params.filter,
          'sort': params.sort,
        },
      ),
    );
  }

  @override
  Future<CandidateModel?> getById(String id) async {
    try {
      return await _apiClient.getType(
        '/candidates/$id',
        fromJson: CandidateModel.fromJson,
      );
    } on ApiClientException catch (e) {
      if (e.error.response?.statusCode == 404) return null;
      rethrow;
    }
  }

  @override
  Future<void> updateStatus(UpdateStatusParams params) {
    return _apiClient.patch<void>(
      '/candidates/${params.id}/status',
      data: {'status': params.status},
    );
  }
}
