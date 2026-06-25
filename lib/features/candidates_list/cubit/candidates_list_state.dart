import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'candidates_list_state.freezed.dart';

enum CandidatesListStatus { initial, loading, loaded, error }

@freezed
abstract class CandidatesListState with _$CandidatesListState {
  const factory CandidatesListState({
    @Default(CandidatesListStatus.initial) CandidatesListStatus status,
    @Default([]) List<CandidateModel> allCandidates,
    @Default([]) List<CandidateModel> filteredCandidates,
    @Default([]) List<CandidateModel> displayedCandidates,
    @Default('') String searchQuery,
    String? verdictFilter,
    @Default(SortOption.dateAdded) SortOption sortBy,
    @Default(1) int currentPage,
    @Default(false) bool hasMore,
    @Default(false) bool isOffline,
    String? errorMessage,
  }) = _CandidatesListState;
}
