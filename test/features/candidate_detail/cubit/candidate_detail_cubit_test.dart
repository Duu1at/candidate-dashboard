import 'package:bloc_test/bloc_test.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements CandidateRepository {}

CandidateModel _candidate({String status = 'new'}) => CandidateModel(
  id: '1',
  name: 'Test User',
  position: 'Flutter Dev',
  posLabel: 'Middle',
  file: '',
  email: 'test@test.com',
  phone: '+7 000 000 00 00',
  city: 'Bishkek',
  tg: '@test',
  exp: const [],
  totalExp: '2 года',
  stack: 'Flutter, Dart',
  edu: 'КГТУ',
  verdict: 'Рекомендован',
  vc: 'verdict-green',
  criteria: const [],
  summary: 'Good candidate',
  questions: const [],
  status: status,
  dateAdded: '2024-01-01',
);

void main() {
  setUpAll(() {
    registerFallbackValue(const UpdateStatusParams(id: '', status: ''));
  });

  group('CandidateDetailCubit', () {
    late _MockRepo repo;

    setUp(() {
      repo = _MockRepo();
      when(() => repo.candidatesStream).thenAnswer((_) => const Stream.empty());
      when(() => repo.isOffline).thenReturn(false);
    });

    CandidateDetailCubit buildCubit() => CandidateDetailCubit(repo);

    test('starts in initial status with no candidate', () {
      final cubit = buildCubit();
      expect(cubit.state.status, CandidateDetailStatus.initial);
      expect(cubit.state.candidate, isNull);
      cubit.close();
    });

    blocTest<CandidateDetailCubit, CandidateDetailState>(
      'load: emits loading then loaded with the returned candidate',
      build: buildCubit,
      setUp: () {
        when(() => repo.getById('1')).thenAnswer((_) async => _candidate());
      },
      act: (c) => c.load('1'),
      expect: () => [
        const CandidateDetailState(status: CandidateDetailStatus.loading),
        CandidateDetailState(
          status: CandidateDetailStatus.loaded,
          candidate: _candidate(),
        ),
      ],
    );

    blocTest<CandidateDetailCubit, CandidateDetailState>(
      'load: emits notFound when repository returns null',
      build: buildCubit,
      setUp: () {
        when(() => repo.getById(any())).thenAnswer((_) async => null);
      },
      act: (c) => c.load('999'),
      expect: () => [
        const CandidateDetailState(status: CandidateDetailStatus.loading),
        const CandidateDetailState(status: CandidateDetailStatus.notFound),
      ],
    );

    blocTest<CandidateDetailCubit, CandidateDetailState>(
      'load: emits error with fixed message when repository throws',
      build: buildCubit,
      setUp: () {
        when(() => repo.getById(any())).thenThrow(Exception('network'));
      },
      act: (c) => c.load('1'),
      expect: () => [
        const CandidateDetailState(status: CandidateDetailStatus.loading),
        const CandidateDetailState(
          status: CandidateDetailStatus.error,
          errorMessage: 'Не удалось загрузить кандидата. Проверьте соединение.',
        ),
      ],
    );

    blocTest<CandidateDetailCubit, CandidateDetailState>(
      'updateStatus success: optimistic update then transitions to loaded',
      build: buildCubit,
      seed: () => CandidateDetailState(
        status: CandidateDetailStatus.loaded,
        candidate: _candidate(),
      ),
      setUp: () {
        when(() => repo.updateStatus(any())).thenAnswer((_) async {});
      },
      act: (c) => c.updateStatus('review'),
      expect: () => [
        CandidateDetailState(
          status: CandidateDetailStatus.updatingStatus,
          candidate: _candidate(status: 'review'),
        ),
        CandidateDetailState(
          status: CandidateDetailStatus.loaded,
          candidate: _candidate(status: 'review'),
        ),
      ],
    );

    blocTest<CandidateDetailCubit, CandidateDetailState>(
      'updateStatus failure: optimistic update then rolls back candidate and '
      'clears error after 100 ms',
      build: buildCubit,
      seed: () => CandidateDetailState(
        status: CandidateDetailStatus.loaded,
        candidate: _candidate(),
      ),
      setUp: () {
        when(() => repo.updateStatus(any())).thenThrow(Exception('api error'));
      },
      act: (c) => c.updateStatus('review'),
      expect: () => [
        // 1. optimistic: candidate updated immediately
        CandidateDetailState(
          status: CandidateDetailStatus.updatingStatus,
          candidate: _candidate(status: 'review'),
        ),
        // 2. error: rolled back to previous candidate
        CandidateDetailState(
          status: CandidateDetailStatus.error,
          candidate: _candidate(status: 'new'),
          errorMessage: 'Ошибка обновления статуса. Попробуйте ещё раз.',
        ),
        // 3. loaded: error cleared after delay, candidate stays rolled back
        CandidateDetailState(
          status: CandidateDetailStatus.loaded,
          candidate: _candidate(status: 'new'),
        ),
      ],
    );

    blocTest<CandidateDetailCubit, CandidateDetailState>(
      'updateStatus: is no-op when candidate is null',
      build: buildCubit,
      act: (c) => c.updateStatus('review'),
      expect: () => [],
    );

    blocTest<CandidateDetailCubit, CandidateDetailState>(
      'updateStatus: passes correct params to repository',
      build: buildCubit,
      seed: () => CandidateDetailState(
        status: CandidateDetailStatus.loaded,
        candidate: _candidate(),
      ),
      setUp: () {
        when(() => repo.updateStatus(any())).thenAnswer((_) async {});
      },
      act: (c) => c.updateStatus('invited'),
      verify: (_) {
        verify(
          () => repo.updateStatus(
            const UpdateStatusParams(id: '1', status: 'invited'),
          ),
        ).called(1);
      },
    );
  });
}
