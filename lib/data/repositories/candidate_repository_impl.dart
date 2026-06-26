import 'dart:async';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

@LazySingleton(as: CandidateRepository)
final class CandidateRepositoryImpl implements CandidateRepository {
  CandidateRepositoryImpl({
    required RemoteDatasource remote,
    required LocalDatasource local,
    required ConnectionService connection,
  }) : _remote = remote,
       _local = local,
       _connection = connection;

  final RemoteDatasource _remote;
  final LocalDatasource _local;
  final ConnectionService _connection;

  List<CandidateModel> _currentItems = [];

  bool _isOffline = false;

  final _controller = StreamController<List<CandidateModel>>.broadcast();

  @override
  bool get isOffline => _isOffline;

  @override
  Stream<List<CandidateModel>> get candidatesStream => _controller.stream;

  @override
  Future<CandidatesPage> getCandidates(GetCandidatesParams params) async {
    final hasNetwork = await _connection.checkInternetConnection();

    if (hasNetwork) {
      try {
        final result = await _remote.getCandidates(params);

        final statuses = await _local.getLocalStatuses();
        final items = result.items
            .map(
              (c) => statuses.containsKey(c.id)
                  ? c.copyWith(status: statuses[c.id]!)
                  : c,
            )
            .toList();

        if (params.page == 1) {
          _currentItems = items;
        } else {
          _currentItems = [..._currentItems, ...items];
        }
        _isOffline = false;

        if (params.page == 1 &&
            params.search.isEmpty &&
            params.filter == null) {
          await _local.cacheCandidates(items);
        }

        return CandidatesPage(
          items: items,
          total: result.total,
          page: result.page,
          limit: result.limit,
        );
      } on Exception catch (_) {}
    }

    if (params.page == 1 && params.search.isEmpty && params.filter == null) {
      final cached = await _local.getCachedCandidates();
      if (cached != null && cached.isNotEmpty) {
        _currentItems = cached;
        _isOffline = true;
        return CandidatesPage(
          items: cached,
          total: cached.length,
          page: 1,
          limit: cached.length,
        );
      }
    }

    throw Exception('Нет данных. Проверьте соединение с интернетом.');
  }

  @override
  Future<CandidateModel?> getById(String id) async {
    final candidate = await _remote.getById(id);
    if (candidate == null) return null;
    final statuses = await _local.getLocalStatuses();
    return statuses.containsKey(id)
        ? candidate.copyWith(status: statuses[id]!)
        : candidate;
  }

  @override
  Future<void> updateStatus(UpdateStatusParams params) async {
    final prev = _currentItems.firstWhereOrNull((c) => c.id == params.id);

    if (prev != null) {
      _currentItems = _currentItems
          .map((c) => c.id == params.id ? c.copyWith(status: params.status) : c)
          .toList();
      _controller.add(List.unmodifiable(_currentItems));
    }

    await _local.saveLocalStatus(params.id, params.status);

    try {
      await _remote.updateStatus(params);
    } catch (e) {
      if (prev != null) {
        _currentItems = _currentItems
            .map((c) => c.id == params.id ? prev : c)
            .toList();
        _controller.add(List.unmodifiable(_currentItems));
        await _local.saveLocalStatus(params.id, prev.status);
      }
      rethrow;
    }
  }
}
