part of 'candidates_list_cubit.dart';

enum CandidatesListStatus { initial, loading, loadingMore, loaded, error }

class CandidatesListState extends Equatable {
  const CandidatesListState({
    this.status = CandidatesListStatus.initial,
    this.items = const [],
    this.currentPage = 1,
    this.totalItems = 0,
    this.isOffline = false,
    this.errorMessage,
  });

  final CandidatesListStatus status;
  final List<CandidateModel> items;
  final int currentPage;
  final int totalItems;
  final bool isOffline;
  final String? errorMessage;

  bool get hasMore => items.length < totalItems;

  CandidatesListState copyWith({
    CandidatesListStatus? status,
    List<CandidateModel>? items,
    int? currentPage,
    int? totalItems,
    bool? isOffline,
    Object? errorMessage = _sentinel,
  }) {
    return CandidatesListState(
      status: status ?? this.status,
      items: items ?? this.items,
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
    currentPage,
    totalItems,
    isOffline,
    errorMessage,
  ];
}

const _sentinel = Object();
