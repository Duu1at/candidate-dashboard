import 'package:injectable/injectable.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

@LazySingleton(as: RemoteDatasource)
final class RemoteDatasourceImpl implements RemoteDatasource {
  const RemoteDatasourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<CandidatesPage> getCandidates({
    required int page,
    required int limit,
    String search = '',
    String? filter,
    String sort = 'date_added',
  }) {
    return _apiClient.getType(
      '/candidates',
      fromJson: CandidatesPage.fromJson,
      params: GetApiParams(
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search.isNotEmpty) 'search': search,
          'filter': ?filter,
          'sort': sort,
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
  Future<void> updateStatus(String id, String status) {
    return _apiClient.patch<void>(
      '/candidates/$id/status',
      data: {'status': status},
    );
  }
}
