import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/candidate_filter.dart';
import '../../../data/models/candidate.dart';

part 'candidates_list_state.freezed.dart';

enum CandidatesListStatus { initial, loading, loaded, error }

@freezed
abstract class CandidatesListState with _$CandidatesListState {
  const factory CandidatesListState({
    @Default(CandidatesListStatus.initial) CandidatesListStatus status,
    @Default([]) List<Candidate> allCandidates,
    @Default([]) List<Candidate> filteredCandidates,
    @Default([]) List<Candidate> displayedCandidates,
    @Default('') String searchQuery,
    String? verdictFilter,
    @Default(SortOption.dateAdded) SortOption sortBy,
    @Default(1) int currentPage,
    @Default(false) bool hasMore,
    @Default(false) bool isOffline,
    String? errorMessage,
  }) = _CandidatesListState;
}
