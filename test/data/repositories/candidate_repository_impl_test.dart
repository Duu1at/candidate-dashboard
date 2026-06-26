import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRemote extends Mock implements RemoteDatasource {}

class _MockLocal extends Mock implements LocalDatasource {}

class _MockConnection extends Mock implements ConnectionService {}

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
      summary: 'Good',
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
    registerFallbackValue(const UpdateStatusParams(id: '', status: ''));
    registerFallbackValue(<CandidateModel>[]);
  });

  group('CandidateRepositoryImpl', () {
    late _MockRemote remote;
    late _MockLocal local;
    late _MockConnection connection;
    late CandidateRepositoryImpl repo;

    setUp(() {
      remote = _MockRemote();
      local = _MockLocal();
      connection = _MockConnection();
      when(
        () => connection.onConnectivityChanged,
      ).thenAnswer((_) => const Stream.empty());
      when(() => local.getPendingQueue()).thenAnswer((_) async => {});
      repo = CandidateRepositoryImpl(
        remote: remote,
        local: local,
        connection: connection,
      );
    });

    Future<void> seedCurrentItems(List<CandidateModel> items) async {
      when(
        () => connection.checkInternetConnection(),
      ).thenAnswer((_) async => true);
      when(
        () => remote.getCandidates(any()),
      ).thenAnswer((_) async => _page(items));
      when(() => local.getLocalStatuses()).thenAnswer((_) async => {});
      when(() => local.cacheCandidates(any())).thenAnswer((_) async {});
      await repo.getCandidates(
        const GetCandidatesParams(page: 1, limit: 10),
      );
    }

    group('getCandidates', () {
      test(
        'online page 1 no filter: applies local statuses, caches, returns page',
        () async {
          when(
            () => connection.checkInternetConnection(),
          ).thenAnswer((_) async => true);
          when(
            () => remote.getCandidates(any()),
          ).thenAnswer((_) async => _page([_candidate()]));
          when(
            () => local.getLocalStatuses(),
          ).thenAnswer((_) async => {'1': 'review'});
          when(() => local.cacheCandidates(any())).thenAnswer((_) async {});

          final result = await repo.getCandidates(
            const GetCandidatesParams(page: 1, limit: 10),
          );

          expect(result.items.single.status, 'review');
          expect(result.total, 1);
          expect(repo.isOffline, isFalse);
          verify(() => local.cacheCandidates(any())).called(1);
        },
      );

      test(
        'online page 1 with active search: returns data but skips caching',
        () async {
          when(
            () => connection.checkInternetConnection(),
          ).thenAnswer((_) async => true);
          when(
            () => remote.getCandidates(any()),
          ).thenAnswer((_) async => _page([_candidate()]));
          when(() => local.getLocalStatuses()).thenAnswer((_) async => {});

          await repo.getCandidates(
            const GetCandidatesParams(page: 1, limit: 10, search: 'Иван'),
          );

          verifyNever(() => local.cacheCandidates(any()));
        },
      );

      test(
        'online page 2: returns second page without caching',
        () async {
          when(
            () => connection.checkInternetConnection(),
          ).thenAnswer((_) async => true);
          when(() => local.getLocalStatuses()).thenAnswer((_) async => {});
          when(() => local.cacheCandidates(any())).thenAnswer((_) async {});
          when(
            () => remote.getCandidates(any()),
          ).thenAnswer((_) async => _page([_candidate(id: '1')], total: 2));
          await repo.getCandidates(
            const GetCandidatesParams(page: 1, limit: 10),
          );

          clearInteractions(local);

          // page 2
          when(() => remote.getCandidates(any())).thenAnswer(
            (_) async => CandidatesPage(
              items: [_candidate(id: '2')],
              total: 2,
              page: 2,
              limit: 10,
            ),
          );
          final result = await repo.getCandidates(
            const GetCandidatesParams(page: 2, limit: 10),
          );

          expect(result.items.single.id, '2');
          verifyNever(() => local.cacheCandidates(any()));
        },
      );

      test(
        'remote throws, page 1 no filter, cache exists: returns cache and sets isOffline',
        () async {
          when(
            () => connection.checkInternetConnection(),
          ).thenAnswer((_) async => true);
          when(
            () => remote.getCandidates(any()),
          ).thenThrow(Exception('timeout'));
          when(
            () => local.getCachedCandidates(),
          ).thenAnswer((_) async => [_candidate()]);

          final result = await repo.getCandidates(
            const GetCandidatesParams(page: 1, limit: 10),
          );

          expect(result.items, [_candidate()]);
          expect(repo.isOffline, isTrue);
        },
      );

      test(
        'no network, page 1 no filter, cache exists: returns cache and sets isOffline',
        () async {
          when(
            () => connection.checkInternetConnection(),
          ).thenAnswer((_) async => false);
          when(
            () => local.getCachedCandidates(),
          ).thenAnswer((_) async => [_candidate()]);

          final result = await repo.getCandidates(
            const GetCandidatesParams(page: 1, limit: 10),
          );

          expect(result.items, [_candidate()]);
          expect(repo.isOffline, isTrue);
          verifyNever(() => remote.getCandidates(any()));
        },
      );

      test(
        'no network, no cache: throws exception',
        () async {
          when(
            () => connection.checkInternetConnection(),
          ).thenAnswer((_) async => false);
          when(() => local.getCachedCandidates()).thenAnswer((_) async => null);

          await expectLater(
            () => repo.getCandidates(
              const GetCandidatesParams(page: 1, limit: 10),
            ),
            throwsA(isA<Exception>()),
          );
        },
      );

      test(
        'no network, page 1 with search: throws without checking cache',
        () async {
          when(
            () => connection.checkInternetConnection(),
          ).thenAnswer((_) async => false);

          await expectLater(
            () => repo.getCandidates(
              const GetCandidatesParams(
                page: 1,
                limit: 10,
                search: 'test',
              ),
            ),
            throwsA(isA<Exception>()),
          );
          verifyNever(() => local.getCachedCandidates());
        },
      );
    });

    group('getById', () {
      test(
        'candidate found, no local status: returns candidate unchanged',
        () async {
          final c = _candidate();
          when(() => remote.getById('1')).thenAnswer((_) async => c);
          when(() => local.getLocalStatuses()).thenAnswer((_) async => {});

          final result = await repo.getById('1');

          expect(result, c);
        },
      );

      test(
        'candidate found, local status exists: returns candidate with local status',
        () async {
          when(() => remote.getById('1')).thenAnswer((_) async => _candidate());
          when(
            () => local.getLocalStatuses(),
          ).thenAnswer((_) async => {'1': 'invited'});

          final result = await repo.getById('1');

          expect(result?.status, 'invited');
          expect(result?.id, '1');
        },
      );

      test(
        'remote returns null: returns null without loading statuses',
        () async {
          when(() => remote.getById('999')).thenAnswer((_) async => null);

          final result = await repo.getById('999');

          expect(result, isNull);
          verifyNever(() => local.getLocalStatuses());
        },
      );
    });

    group('updateStatus', () {
      test(
        'success with known candidate: emits updated item on stream, saves local status, calls remote',
        () async {
          await seedCurrentItems([_candidate()]);

          when(
            () => local.saveLocalStatus(any(), any()),
          ).thenAnswer((_) async {});
          when(() => remote.updateStatus(any())).thenAnswer((_) async {});

          final emitted = <List<CandidateModel>>[];
          final sub = repo.candidatesStream.listen(emitted.add);

          await repo.updateStatus(
            const UpdateStatusParams(id: '1', status: 'review'),
          );
          await sub.cancel();

          expect(emitted, hasLength(1));
          expect(emitted.single.single.status, 'review');
          verify(() => local.saveLocalStatus('1', 'review')).called(1);
          verify(
            () => remote.updateStatus(
              const UpdateStatusParams(id: '1', status: 'review'),
            ),
          ).called(1);
        },
      );

      test(
        'success without known candidate: saves local status, calls remote, no stream emit',
        () async {
          when(
            () => connection.checkInternetConnection(),
          ).thenAnswer((_) async => true);
          when(
            () => local.saveLocalStatus(any(), any()),
          ).thenAnswer((_) async {});
          when(() => remote.updateStatus(any())).thenAnswer((_) async {});

          final emitted = <List<CandidateModel>>[];
          final sub = repo.candidatesStream.listen(emitted.add);

          await repo.updateStatus(
            const UpdateStatusParams(id: '99', status: 'review'),
          );
          await sub.cancel();

          expect(emitted, isEmpty);
          verify(() => local.saveLocalStatus('99', 'review')).called(1);
          verify(() => remote.updateStatus(any())).called(1);
        },
      );

      test(
        'failure with known candidate: optimistic emit, rollback emit, '
        'restores original local status, rethrows',
        () async {
          await seedCurrentItems([_candidate()]);

          when(
            () => local.saveLocalStatus(any(), any()),
          ).thenAnswer((_) async {});
          when(
            () => remote.updateStatus(any()),
          ).thenThrow(Exception('api error'));

          final emitted = <List<CandidateModel>>[];
          final sub = repo.candidatesStream.listen(emitted.add);

          await expectLater(
            () => repo.updateStatus(
              const UpdateStatusParams(id: '1', status: 'review'),
            ),
            throwsA(isA<Exception>()),
          );
          await sub.cancel();

          expect(emitted, hasLength(2));
          expect(emitted[0].single.status, 'review');
          expect(emitted[1].single.status, 'new');

          verify(() => local.saveLocalStatus('1', 'review')).called(1);
          verify(() => local.saveLocalStatus('1', 'new')).called(1);
        },
      );

      test(
        'failure without known candidate: saves local status, rethrows, no stream emit',
        () async {
          when(
            () => connection.checkInternetConnection(),
          ).thenAnswer((_) async => true);
          when(
            () => local.saveLocalStatus(any(), any()),
          ).thenAnswer((_) async {});
          when(
            () => remote.updateStatus(any()),
          ).thenThrow(Exception('api error'));

          final emitted = <List<CandidateModel>>[];
          final sub = repo.candidatesStream.listen(emitted.add);

          await expectLater(
            () => repo.updateStatus(
              const UpdateStatusParams(id: '99', status: 'review'),
            ),
            throwsA(isA<Exception>()),
          );
          await sub.cancel();

          expect(emitted, isEmpty);
          verify(() => local.saveLocalStatus('99', 'review')).called(1);
          verifyNever(() => local.saveLocalStatus('99', any()));
        },
      );
    });
  });
}
