import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/candidate_model.dart';

part 'candidate_detail_state.freezed.dart';

enum CandidateDetailStatus { initial, loading, loaded, notFound, updatingStatus, error }

@freezed
abstract class CandidateDetailState with _$CandidateDetailState {
  const factory CandidateDetailState({
    @Default(CandidateDetailStatus.initial) CandidateDetailStatus status,
    CandidateModel? candidate,
    String? errorMessage,
  }) = _CandidateDetailState;
}
