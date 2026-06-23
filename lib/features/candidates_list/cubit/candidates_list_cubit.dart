import 'dart:async';
import 'package:candidate_dashboard/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';

const _pageSize = 10;

class CandidatesListCubit extends Cubit<CandidatesListState> {
  CandidatesListCubit(this._repository) : super(const CandidatesListState());

  final CandidateRepository _repository;
  StreamSubscription<List<Candidate>>? _sub;

  Future<void> load({bool forceRefresh = false}) async {
    emit(state.copyWith(status: CandidatesListStatus.loading));
    try {
      final candidates = await _repository.getCandidates(
        forceRefresh: forceRefresh,
      );
      _sub?.cancel();
      _sub = _repository.candidatesStream.listen(_onRemoteUpdate);
      _emitLoaded(candidates, _repository.isOffline);
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidatesListStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onRemoteUpdate(List<Candidate> candidates) {
    _emitLoaded(candidates, _repository.isOffline);
  }

  void _emitLoaded(List<Candidate> all, bool offline) {
    final filtered = filterAndSort(
      candidates: all,
      query: state.searchQuery,
      verdictFilter: state.verdictFilter,
      sortBy: state.sortBy,
    );
    emit(
      state.copyWith(
        status: CandidatesListStatus.loaded,
        allCandidates: all,
        filteredCandidates: filtered,
        displayedCandidates: _page(filtered, 1),
        currentPage: 1,
        hasMore: filtered.length > _pageSize,
        isOffline: offline,
      ),
    );
  }

  void search(String query) {
    final filtered = filterAndSort(
      candidates: state.allCandidates,
      query: query,
      verdictFilter: state.verdictFilter,
      sortBy: state.sortBy,
    );
    emit(
      state.copyWith(
        searchQuery: query,
        filteredCandidates: filtered,
        displayedCandidates: _page(filtered, 1),
        currentPage: 1,
        hasMore: filtered.length > _pageSize,
      ),
    );
  }

  void filterByVerdict(String? verdict) {
    final filtered = filterAndSort(
      candidates: state.allCandidates,
      query: state.searchQuery,
      verdictFilter: verdict,
      sortBy: state.sortBy,
    );
    emit(
      state.copyWith(
        verdictFilter: verdict,
        filteredCandidates: filtered,
        displayedCandidates: _page(filtered, 1),
        currentPage: 1,
        hasMore: filtered.length > _pageSize,
      ),
    );
  }

  void sortBy(SortOption option) {
    final filtered = filterAndSort(
      candidates: state.allCandidates,
      query: state.searchQuery,
      verdictFilter: state.verdictFilter,
      sortBy: option,
    );
    emit(
      state.copyWith(
        sortBy: option,
        filteredCandidates: filtered,
        displayedCandidates: _page(filtered, 1),
        currentPage: 1,
        hasMore: filtered.length > _pageSize,
      ),
    );
  }

  void loadNextPage() {
    final nextPage = state.currentPage + 1;
    final more = _page(state.filteredCandidates, nextPage);
    if (more.isEmpty) return;
    final combined = [...state.displayedCandidates, ...more];
    emit(
      state.copyWith(
        displayedCandidates: combined,
        currentPage: nextPage,
        hasMore: combined.length < state.filteredCandidates.length,
      ),
    );
  }

  List<Candidate> _page(List<Candidate> list, int page) {
    final start = (page - 1) * _pageSize;
    if (start >= list.length) return [];
    return list.sublist(start, (start + _pageSize).clamp(0, list.length));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
