part of 'candidates_list_cubit.dart';

enum CandidatesListStatus { initial, loading, loaded, error }

class CandidatesListState extends Equatable {
  const CandidatesListState({
    this.status = CandidatesListStatus.initial,
    this.allCandidates = const [],
    this.filteredCandidates = const [],
    this.displayedCandidates = const [],
    this.searchQuery = '',
    this.verdictFilter,
    this.sortBy = SortOption.dateAdded,
    this.currentPage = 1,
    this.hasMore = false,
    this.isOffline = false,
    this.errorMessage,
  });

  final CandidatesListStatus status;
  final List<CandidateModel> allCandidates;
  final List<CandidateModel> filteredCandidates;
  final List<CandidateModel> displayedCandidates;
  final String searchQuery;
  final String? verdictFilter;
  final SortOption sortBy;
  final int currentPage;
  final bool hasMore;
  final bool isOffline;
  final String? errorMessage;

  CandidatesListState copyWith({
    CandidatesListStatus? status,
    List<CandidateModel>? allCandidates,
    List<CandidateModel>? filteredCandidates,
    List<CandidateModel>? displayedCandidates,
    String? searchQuery,
    Object? verdictFilter = _sentinel,
    SortOption? sortBy,
    int? currentPage,
    bool? hasMore,
    bool? isOffline,
    Object? errorMessage = _sentinel,
  }) {
    return CandidatesListState(
      status: status ?? this.status,
      allCandidates: allCandidates ?? this.allCandidates,
      filteredCandidates: filteredCandidates ?? this.filteredCandidates,
      displayedCandidates: displayedCandidates ?? this.displayedCandidates,
      searchQuery: searchQuery ?? this.searchQuery,
      verdictFilter: identical(verdictFilter, _sentinel)
          ? this.verdictFilter
          : verdictFilter as String?,
      sortBy: sortBy ?? this.sortBy,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isOffline: isOffline ?? this.isOffline,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allCandidates,
    filteredCandidates,
    displayedCandidates,
    searchQuery,
    verdictFilter,
    sortBy,
    currentPage,
    hasMore,
    isOffline,
    errorMessage,
  ];
}

const _sentinel = Object();
