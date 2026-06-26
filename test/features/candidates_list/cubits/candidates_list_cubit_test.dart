import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepo extends Mock implements CandidateRepository {}

CandidateModel _candidate({String id = '1', String status = 'new'}) =>
    CandidateModel(
      id: id,
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

CandidatesPage _page(
  List<CandidateModel> items, {
  int? total,
  int page = 1,
}) => CandidatesPage(
  items: items,
  total: total ?? items.length,
  page: page,
  limit: 10,
);

void main() {
  setUpAll(() {
    registerFallbackValue(const GetCandidatesParams(page: 1, limit: 10));
  });

  group('CandidatesListCubit', () {
    late _MockRepo repo;
    late CandidateFiltersCubit filters;
    late StreamController<List<CandidateModel>> streamCtrl;

    setUp(() {
      repo = _MockRepo();
      filters = CandidateFiltersCubit();
      streamCtrl = StreamController<List<CandidateModel>>.broadcast();
      when(() => repo.candidatesStream).thenAnswer((_) => streamCtrl.stream);
      when(() => repo.isOffline).thenReturn(false);
    });

    tearDown(() async {
      await filters.close();
      await streamCtrl.close();
    });

    CandidatesListCubit buildCubit() => CandidatesListCubit(repo, filters);

    test('starts in initial status with empty items', () {
      final cubit = buildCubit();
      expect(cubit.state.status, CandidatesListStatus.initial);
      expect(cubit.state.items, isEmpty);
      expect(cubit.state.hasMore, isFalse);
      cubit.close();
    });

    blocTest<CandidatesListCubit, CandidatesListState>(
      'load: emits loading then loaded with items from the first page',
      build: buildCubit,
      setUp: () {
        when(
          () => repo.getCandidates(any()),
        ).thenAnswer((_) async => _page([_candidate()], total: 1));
      },
      act: (c) => c.load(),
      expect: () => [
        const CandidatesListState(
          status: CandidatesListStatus.loading,
          items: [],
          currentPage: 1,
          totalItems: 0,
        ),
        isA<CandidatesListState>()
            .having((s) => s.status, 'status', CandidatesListStatus.loaded)
            .having((s) => s.items, 'items', [_candidate()])
            .having((s) => s.totalItems, 'totalItems', 1)
            .having((s) => s.isOffline, 'isOffline', false),
      ],
    );

    blocTest<CandidatesListCubit, CandidatesListState>(
      'load: emits error when repository throws',
      build: buildCubit,
      setUp: () {
        when(
          () => repo.getCandidates(any()),
        ).thenThrow(Exception('network error'));
      },
      act: (c) => c.load(),
      expect: () => [
        const CandidatesListState(
          status: CandidatesListStatus.loading,
          items: [],
          currentPage: 1,
          totalItems: 0,
        ),
        isA<CandidatesListState>()
            .having((s) => s.status, 'status', CandidatesListStatus.error)
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              contains('Exception'),
            ),
      ],
    );

    blocTest<CandidatesListCubit, CandidatesListState>(
      'load: propagates isOffline flag from repository',
      build: buildCubit,
      setUp: () {
        when(() => repo.isOffline).thenReturn(true);
        when(
          () => repo.getCandidates(any()),
        ).thenAnswer((_) async => _page([_candidate()], total: 1));
      },
      act: (c) => c.load(),
      expect: () => [
        isA<CandidatesListState>().having(
          (s) => s.status,
          'status',
          CandidatesListStatus.loading,
        ),
        isA<CandidatesListState>().having(
          (s) => s.isOffline,
          'isOffline',
          true,
        ),
      ],
    );

    blocTest<CandidatesListCubit, CandidatesListState>(
      'loadNextPage: appends second page to existing items',
      build: buildCubit,
      setUp: () {
        final page1 = List.generate(10, (i) => _candidate(id: '$i'));
        final page2 = [_candidate(id: '10')];
        when(() => repo.getCandidates(any())).thenAnswer((inv) async {
          final p = (inv.positionalArguments[0] as GetCandidatesParams).page;
          return p == 1
              ? CandidatesPage(items: page1, total: 11, page: 1, limit: 10)
              : CandidatesPage(items: page2, total: 11, page: 2, limit: 10);
        });
      },
      act: (c) async {
        await c.load();
        await c.loadNextPage();
      },
      expect: () => [
        isA<CandidatesListState>().having(
          (s) => s.status,
          'status',
          CandidatesListStatus.loading,
        ),
        isA<CandidatesListState>()
            .having((s) => s.status, 'status', CandidatesListStatus.loaded)
            .having((s) => s.items.length, 'items.length', 10)
            .having((s) => s.hasMore, 'hasMore', true),
        isA<CandidatesListState>().having(
          (s) => s.status,
          'status',
          CandidatesListStatus.loadingMore,
        ),
        isA<CandidatesListState>()
            .having((s) => s.status, 'status', CandidatesListStatus.loaded)
            .having((s) => s.items.length, 'items.length', 11)
            .having((s) => s.currentPage, 'currentPage', 2)
            .having((s) => s.hasMore, 'hasMore', false),
      ],
    );

    blocTest<CandidatesListCubit, CandidatesListState>(
      'loadNextPage: is no-op when hasMore is false',
      build: buildCubit,
      setUp: () {
        when(
          () => repo.getCandidates(any()),
        ).thenAnswer((_) async => _page([_candidate()], total: 1));
      },
      act: (c) async {
        await c.load();
        await c.loadNextPage();
      },
      expect: () => [
        isA<CandidatesListState>().having(
          (s) => s.status,
          'status',
          CandidatesListStatus.loading,
        ),
        isA<CandidatesListState>()
            .having((s) => s.status, 'status', CandidatesListStatus.loaded)
            .having((s) => s.hasMore, 'hasMore', false),
        // no additional states — loadNextPage bailed early
      ],
    );

    blocTest<CandidatesListCubit, CandidatesListState>(
      'stream update: refreshes items while cubit is in loaded state',
      build: buildCubit,
      setUp: () {
        when(
          () => repo.getCandidates(any()),
        ).thenAnswer((_) async => _page([_candidate()], total: 1));
      },
      act: (c) async {
        await c.load();
        streamCtrl.add([_candidate(status: 'review')]);
        await Future<void>.delayed(Duration.zero);
      },
      expect: () => [
        isA<CandidatesListState>().having(
          (s) => s.status,
          'status',
          CandidatesListStatus.loading,
        ),
        isA<CandidatesListState>()
            .having((s) => s.status, 'status', CandidatesListStatus.loaded)
            .having((s) => s.items.first.status, 'initial status', 'new'),
        isA<CandidatesListState>().having(
          (s) => s.items.first.status,
          'updated status',
          'review',
        ),
      ],
    );

    blocTest<CandidatesListCubit, CandidatesListState>(
      'filter change: triggers a full reload (loading → loaded)',
      build: buildCubit,
      setUp: () {
        when(
          () => repo.getCandidates(any()),
        ).thenAnswer((_) async => _page([_candidate()], total: 1));
      },
      act: (c) async {
        await c.load();
        filters.search('Иван');
      },
      wait: const Duration(milliseconds: 50),
      expect: () => [
        // initial load
        isA<CandidatesListState>().having(
          (s) => s.status,
          'status',
          CandidatesListStatus.loading,
        ),
        isA<CandidatesListState>().having(
          (s) => s.status,
          'status',
          CandidatesListStatus.loaded,
        ),
        // reload triggered by filter change
        isA<CandidatesListState>().having(
          (s) => s.status,
          'status',
          CandidatesListStatus.loading,
        ),
        isA<CandidatesListState>().having(
          (s) => s.status,
          'status',
          CandidatesListStatus.loaded,
        ),
      ],
    );
  });
}
