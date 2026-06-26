part of 'candidate_filters_cubit.dart';

class CandidateFiltersState extends Equatable {
  const CandidateFiltersState({
    this.searchQuery = '',
    this.verdictFilter,
    this.sortBy = SortOption.dateAdded,
  });

  final String searchQuery;
  final String? verdictFilter;
  final SortOption sortBy;

  CandidateFiltersState copyWith({
    String? searchQuery,
    Object? verdictFilter = _filtersSentinel,
    SortOption? sortBy,
  }) {
    return CandidateFiltersState(
      searchQuery: searchQuery ?? this.searchQuery,
      verdictFilter: identical(verdictFilter, _filtersSentinel)
          ? this.verdictFilter
          : verdictFilter as String?,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  @override
  List<Object?> get props => [searchQuery, verdictFilter, sortBy];
}

const _filtersSentinel = Object();
