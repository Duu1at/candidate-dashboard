part of 'candidates_list_cubit.dart';

enum CandidatesListStatus { initial, loading, loadingMore, loaded, error }

class CandidatesListState extends Equatable {
  const CandidatesListState({
    this.status = CandidatesListStatus.initial,
    this.items = const [],
    this.searchQuery = '',
    this.verdictFilter,
    this.sortBy = SortOption.dateAdded,
    this.currentPage = 1,
    this.totalItems = 0,
    this.isOffline = false,
    this.errorMessage,
  });

  final CandidatesListStatus status;
  final List<CandidateModel> items;
  final String searchQuery;
  final String? verdictFilter;
  final SortOption sortBy;
  final int currentPage;
  final int totalItems;
  final bool isOffline;
  final String? errorMessage;

  bool get hasMore => items.length < totalItems;

  CandidatesListState copyWith({
    CandidatesListStatus? status,
    List<CandidateModel>? items,
    String? searchQuery,
    Object? verdictFilter = _sentinel,
    SortOption? sortBy,
    int? currentPage,
    int? totalItems,
    bool? isOffline,
    Object? errorMessage = _sentinel,
  }) {
    return CandidatesListState(
      status: status ?? this.status,
      items: items ?? this.items,
      searchQuery: searchQuery ?? this.searchQuery,
      verdictFilter: identical(verdictFilter, _sentinel)
          ? this.verdictFilter
          : verdictFilter as String?,
      sortBy: sortBy ?? this.sortBy,
      currentPage: currentPage ?? this.currentPage,
      totalItems: totalItems ?? this.totalItems,
      isOffline: isOffline ?? this.isOffline,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    status,
    items,
    searchQuery,
    verdictFilter,
    sortBy,
    currentPage,
    totalItems,
    isOffline,
    errorMessage,
  ];
}

const _sentinel = Object();
