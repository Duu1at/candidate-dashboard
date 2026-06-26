import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'candidate_filters_state.dart';

export 'candidate_filters_state.dart';

final class CandidateFiltersCubit extends Cubit<CandidateFiltersState> {
  CandidateFiltersCubit() : super(const CandidateFiltersState());

  void search(String query) {
    emit(state.copyWith(searchQuery: query));
  }
  void filterByVerdict(String? verdict) {
    emit(state.copyWith(verdictFilter: verdict));
  }
  void setSortBy(SortOption option) {
    emit(state.copyWith(sortBy: option));
  }
  void reset() {
    emit(const CandidateFiltersState());
  }
}
