import 'package:candidate_dashboard/core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'candidate_filters_state.dart';

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
