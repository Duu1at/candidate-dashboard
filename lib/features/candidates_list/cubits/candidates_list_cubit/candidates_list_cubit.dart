import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';

export 'candidates_list_state.dart';

const _pageSize = 10;

final class CandidatesListCubit extends Cubit<CandidatesListState> {
  CandidatesListCubit(this._repository, this._filters)
    : super(const CandidatesListState()) {
    _filterSub = _filters.stream.listen((_) => _onFiltersChanged());
  }

  final CandidateRepository _repository;
  final CandidateFiltersCubit _filters;
  StreamSubscription<CandidateFiltersState>? _filterSub;
  StreamSubscription<List<CandidateModel>>? _sub;

  Future<void> load({bool forceRefresh = false}) async {
    emit(
      state.copyWith(
        status: CandidatesListStatus.loading,
        items: [],
        currentPage: 1,
        totalItems: 0,
      ),
    );
    _sub?.cancel();
    _sub = _repository.candidatesStream.listen(_onStreamUpdate);
    await _reloadPage1();
  }

  Future<void> loadNextPage() async {
    if (!state.hasMore || state.status == CandidatesListStatus.loadingMore) {
      return;
    }
    emit(state.copyWith(status: CandidatesListStatus.loadingMore));
    try {
      await _fetchPage(state.currentPage + 1);
    } catch (_) {
      emit(state.copyWith(status: CandidatesListStatus.loaded));
    }
  }

  void _onStreamUpdate(List<CandidateModel> updated) {
    if (state.status == CandidatesListStatus.loaded ||
        state.status == CandidatesListStatus.loadingMore) {
      emit(state.copyWith(items: updated));
    }
  }

  Future<void> _onFiltersChanged() async {
    emit(
      state.copyWith(
        status: CandidatesListStatus.loading,
        items: [],
        currentPage: 1,
        totalItems: 0,
      ),
    );
    await _reloadPage1();
  }

  Future<void> _reloadPage1() async {
    try {
      await _fetchPage(1);
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidatesListStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _fetchPage(int page) async {
    final result = await _repository.getCandidates(
      GetCandidatesParams(
        page: page,
        limit: _pageSize,
        search: _filters.state.searchQuery,
        filter: _filters.state.verdictFilter,
        sort: _filters.state.sortBy.value,
      ),
    );
    emit(
      state.copyWith(
        status: CandidatesListStatus.loaded,
        items: page == 1 ? result.items : [...state.items, ...result.items],
        totalItems: result.total,
        currentPage: page,
        isOffline: _repository.isOffline,
      ),
    );
  }

  @override
  Future<void> close() {
    _filterSub?.cancel();
    _sub?.cancel();
    return super.close();
  }
}
