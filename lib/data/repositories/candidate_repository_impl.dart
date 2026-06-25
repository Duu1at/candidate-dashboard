import 'dart:async';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:candidate_dashboard/data/data.dart';

@LazySingleton(as: CandidateRepository)
final class CandidateRepositoryImpl implements CandidateRepository {
  CandidateRepositoryImpl(RemoteDatasource remote, LocalDatasource local)
    : _remote = remote,
      _local = local;

  final RemoteDatasource _remote;
  final LocalDatasource _local;

  List<CandidateModel> _cache = [];
  bool _isOffline = false;
  final _controller = StreamController<List<CandidateModel>>.broadcast();

  @override
  bool get isOffline => _isOffline;

  @override
  Stream<List<CandidateModel>> get candidatesStream => _controller.stream;

  @override
  Future<List<CandidateModel>> getCandidates({bool forceRefresh = false}) async {
    if (_cache.isNotEmpty && !forceRefresh) return List.unmodifiable(_cache);

    final connectivity = await Connectivity().checkConnectivity();
    final hasNetwork = !connectivity.contains(ConnectivityResult.none);

    if (hasNetwork) {
      try {
        var candidates = await _remote.getCandidates();
        final statuses = await _local.getLocalStatuses();
        candidates = candidates
            .map(
              (c) => statuses.containsKey(c.id)
                  ? c.copyWith(status: statuses[c.id]!)
                  : c,
            )
            .toList();
        _cache = candidates;
        _isOffline = false;
        await _local.cacheCandidates(_cache);
        _controller.add(List.unmodifiable(_cache));
        return List.unmodifiable(_cache);
      } catch (_) {
        // fall through to cache
      }
    }

    final cached = await _local.getCachedCandidates();
    if (cached != null && cached.isNotEmpty) {
      _cache = cached;
      _isOffline = true;
      _controller.add(List.unmodifiable(_cache));
      return List.unmodifiable(_cache);
    }

    throw Exception('Нет данных. Проверьте соединение с интернетом.');
  }

  @override
  Future<CandidateModel?> getById(String id) async {
    if (_cache.isEmpty) await getCandidates();
    return _cache.firstWhereOrNull((c) => c.id == id);
  }

  @override
  Future<void> updateStatus(String id, String status) async {
    // optimistic update
    _cache = _cache
        .map((c) => c.id == id ? c.copyWith(status: status) : c)
        .toList();
    _controller.add(List.unmodifiable(_cache));

    // persist locally so it survives restart
    await _local.saveLocalStatus(id, status);

    // mock API call — may throw (~10%)
    await _remote.updateStatus(id, status);
  }
}
