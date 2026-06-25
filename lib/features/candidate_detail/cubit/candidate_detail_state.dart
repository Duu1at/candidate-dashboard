part of 'candidate_detail_cubit.dart';

enum CandidateDetailStatus {
  initial,
  loading,
  loaded,
  notFound,
  updatingStatus,
  error,
}

class CandidateDetailState extends Equatable {
  const CandidateDetailState({
    this.status = CandidateDetailStatus.initial,
    this.candidate,
    this.errorMessage,
  });

  final CandidateDetailStatus status;
  final CandidateModel? candidate;
  final String? errorMessage;

  CandidateDetailState copyWith({
    CandidateDetailStatus? status,
    Object? candidate = _sentinel,
    Object? errorMessage = _sentinel,
  }) {
    return CandidateDetailState(
      status: status ?? this.status,
      candidate: identical(candidate, _sentinel)
          ? this.candidate
          : candidate as CandidateModel?,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [status, candidate, errorMessage];
}

const _sentinel = Object();
