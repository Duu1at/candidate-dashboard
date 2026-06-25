import 'dart:async';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

@LazySingleton(as: CandidateRepository)
final class CandidateRepositoryImpl implements CandidateRepository {
  CandidateRepositoryImpl(
    RemoteDatasource remote,
    LocalDatasource local,
    ConnectionService connection,
  ) : _remote = remote,
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
  Future<CandidatesPage> getCandidates({
    required int page,
    required int limit,
    String search = '',
    String? filter,
    String sort = 'date_added',
  }) async {
    final hasNetwork = await _connection.checkInternetConnection();

    if (hasNetwork) {
      try {
        final result = await _remote.getCandidates(
          page: page,
          limit: limit,
          search: search,
          filter: filter,
          sort: sort,
        );

        final statuses = await _local.getLocalStatuses();
        final items = result.items
            .map(
              (c) => statuses.containsKey(c.id)
                  ? c.copyWith(status: statuses[c.id]!)
                  : c,
            )
            .toList();

        if (page == 1) {
          _currentItems = items;
        } else {
          _currentItems = [..._currentItems, ...items];
        }
        _isOffline = false;

        if (page == 1 && search.isEmpty && filter == null) {
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

    if (page == 1 && search.isEmpty && filter == null) {
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
  Future<CandidateModel?> getById(String id) {
    return _remote.getById(id);
  }

  @override
  Future<void> updateStatus(String id, String status) async {
    final prev = _currentItems.firstWhereOrNull((c) => c.id == id);

    if (prev != null) {
      _currentItems = _currentItems
          .map((c) => c.id == id ? c.copyWith(status: status) : c)
          .toList();
      _controller.add(List.unmodifiable(_currentItems));
    }

    await _local.saveLocalStatus(id, status);

    try {
      await _remote.updateStatus(id, status);
    } catch (e) {
      if (prev != null) {
        _currentItems = _currentItems
            .map((c) => c.id == id ? prev : c)
            .toList();
        _controller.add(List.unmodifiable(_currentItems));
        await _local.saveLocalStatus(id, prev.status);
      }
      rethrow;
    }
  }
}
