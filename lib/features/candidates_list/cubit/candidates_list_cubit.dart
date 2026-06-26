import 'dart:async';
import 'package:candidate_dashboard/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candidate_dashboard/data/data.dart';

part 'candidates_list_state.dart';

const _pageSize = 10;

final class CandidatesListCubit extends Cubit<CandidatesListState> {
  CandidatesListCubit(CandidateRepository repository)
    : _repository = repository,
      super(const CandidatesListState());

  final CandidateRepository _repository;
  StreamSubscription<List<CandidateModel>>? _sub;

  Future<void> load({bool forceRefresh = false}) async {
    final search = state.searchQuery;
    final filter = state.verdictFilter;
    final sort = state.sortBy.value;
    emit(
      state.copyWith(
        status: CandidatesListStatus.loading,
        items: [],
        currentPage: 1,
        totalItems: 0,
      ),
    );
    try {
      final page = await _repository.getCandidates(
        GetCandidatesParams(
          page: 1,
          limit: _pageSize,
          search: search,
          filter: filter,
          sort: sort,
        ),
      );
      _sub?.cancel();
      _sub = _repository.candidatesStream.listen(_onStreamUpdate);
      emit(
        state.copyWith(
          status: CandidatesListStatus.loaded,
          items: page.items,
          totalItems: page.total,
          currentPage: 1,
          isOffline: _repository.isOffline,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidatesListStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onStreamUpdate(List<CandidateModel> updated) {
    if (state.status == CandidatesListStatus.loaded ||
        state.status == CandidatesListStatus.loadingMore) {
      emit(state.copyWith(items: updated));
    }
  }

  Future<void> loadNextPage() async {
    if (!state.hasMore || state.status == CandidatesListStatus.loadingMore) {
      return;
    }

    final nextPage = state.currentPage + 1;
    final search = state.searchQuery;
    final filter = state.verdictFilter;
    final sort = state.sortBy.value;
    emit(state.copyWith(status: CandidatesListStatus.loadingMore));

    try {
      final page = await _repository.getCandidates(
        GetCandidatesParams(
          page: nextPage,
          limit: _pageSize,
          search: search,
          filter: filter,
          sort: sort,
        ),
      );
      emit(
        state.copyWith(
          status: CandidatesListStatus.loaded,
          items: [...state.items, ...page.items],
          totalItems: page.total,
          currentPage: nextPage,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: CandidatesListStatus.loaded));
    }
  }

  Future<void> search(String query) async {
    final filter = state.verdictFilter;
    final sort = state.sortBy.value;
    emit(
      state.copyWith(
        searchQuery: query,
        status: CandidatesListStatus.loading,
        items: [],
        currentPage: 1,
        totalItems: 0,
      ),
    );
    try {
      final page = await _repository.getCandidates(
        GetCandidatesParams(
          page: 1,
          limit: _pageSize,
          search: query,
          filter: filter,
          sort: sort,
        ),
      );
      emit(
        state.copyWith(
          status: CandidatesListStatus.loaded,
          items: page.items,
          totalItems: page.total,
          currentPage: 1,
          isOffline: _repository.isOffline,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidatesListStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> filterByVerdict(String? verdict) async {
    final search = state.searchQuery;
    final sort = state.sortBy.value;
    emit(
      state.copyWith(
        verdictFilter: verdict,
        status: CandidatesListStatus.loading,
        items: [],
        currentPage: 1,
        totalItems: 0,
      ),
    );
    try {
      final page = await _repository.getCandidates(
        GetCandidatesParams(
          page: 1,
          limit: _pageSize,
          search: search,
          filter: verdict,
          sort: sort,
        ),
      );
      emit(
        state.copyWith(
          status: CandidatesListStatus.loaded,
          items: page.items,
          totalItems: page.total,
          currentPage: 1,
          isOffline: _repository.isOffline,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidatesListStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> setSortBy(SortOption option) async {
    final search = state.searchQuery;
    final filter = state.verdictFilter;
    emit(
      state.copyWith(
        sortBy: option,
        status: CandidatesListStatus.loading,
        items: [],
        currentPage: 1,
        totalItems: 0,
      ),
    );
    try {
      final page = await _repository.getCandidates(
        GetCandidatesParams(
          page: 1,
          limit: _pageSize,
          search: search,
          filter: filter,
          sort: option.value,
        ),
      );
      emit(
        state.copyWith(
          status: CandidatesListStatus.loaded,
          items: page.items,
          totalItems: page.total,
          currentPage: 1,
          isOffline: _repository.isOffline,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidatesListStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> resetFilters() async {
    final sort = state.sortBy.value;
    emit(
      state.copyWith(
        searchQuery: '',
        verdictFilter: null,
        status: CandidatesListStatus.loading,
        items: [],
        currentPage: 1,
        totalItems: 0,
      ),
    );
    try {
      final page = await _repository.getCandidates(
        GetCandidatesParams(
          page: 1,
          limit: _pageSize,
          sort: sort,
        ),
      );
      emit(
        state.copyWith(
          status: CandidatesListStatus.loaded,
          items: page.items,
          totalItems: page.total,
          currentPage: 1,
          isOffline: _repository.isOffline,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CandidatesListStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
