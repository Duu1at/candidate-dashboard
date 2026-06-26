import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:candidate_dashboard/data/data.dart';

part 'candidates_list_state.freezed.dart';

enum CandidatesListStatus { initial, loading, loadingMore, loaded, error }

@freezed
abstract class CandidatesListState with _$CandidatesListState {
  const CandidatesListState._();

  const factory CandidatesListState({
    @Default(CandidatesListStatus.initial) CandidatesListStatus status,
    @Default([]) List<CandidateModel> items,
    @Default(1) int currentPage,
    @Default(0) int totalItems,
    @Default(false) bool isOffline,
    String? errorMessage,
  }) = _CandidatesListState;

  bool get hasMore => items.length < totalItems;
}
