import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:candidate_dashboard/core/core.dart';

part 'candidate_filters_state.freezed.dart';

@freezed
abstract class CandidateFiltersState with _$CandidateFiltersState {
  const factory CandidateFiltersState({
    @Default('') String searchQuery,
    String? verdictFilter,
    @Default(SortOption.dateAdded) SortOption sortBy,
  }) = _CandidateFiltersState;
}
