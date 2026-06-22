import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/candidate_repository.dart';
import 'candidate_detail_state.dart';

@injectable
class CandidateDetailCubit extends Cubit<CandidateDetailState> {
  CandidateDetailCubit(this._repository) : super(const CandidateDetailState());

  final CandidateRepository _repository;

  Future<void> load(String id) async {
    emit(state.copyWith(status: CandidateDetailStatus.loading));
    final candidate = await _repository.getById(id);
    if (candidate == null) {
      emit(state.copyWith(status: CandidateDetailStatus.notFound));
      return;
    }
    emit(state.copyWith(
      status: CandidateDetailStatus.loaded,
      candidate: candidate,
    ));
  }

  Future<void> updateStatus(String newStatus) async {
    final prev = state.candidate;
    if (prev == null) return;

    // optimistic update
    emit(state.copyWith(
      status: CandidateDetailStatus.updatingStatus,
      candidate: prev.copyWith(status: newStatus),
    ));

    try {
      await _repository.updateStatus(prev.id, newStatus);
      emit(state.copyWith(status: CandidateDetailStatus.loaded));
    } catch (_) {
      // rollback
      emit(state.copyWith(
        status: CandidateDetailStatus.error,
        candidate: prev,
        errorMessage: 'Ошибка обновления статуса. Попробуйте ещё раз.',
      ));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      emit(state.copyWith(
        status: CandidateDetailStatus.loaded,
        errorMessage: null,
      ));
    }
  }
}
