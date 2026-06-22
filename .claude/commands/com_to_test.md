# Testing reference

Tests are graded on whether they prove the logic works, not on count. Cover the cubit's state transitions, the repository with a mocked data source, one widget test, and the edge cases (empty list, load error).

## Pure-function tests (fastest, do these first)

Filter/sort/search logic should be pure functions, so they test with no setup:

```dart
test('filters by verdict and matches name case-insensitively', () {
  final result = applyFilters(sample, query: 'iva', verdict: Verdict.partial,
      sort: SortBy.name);
  expect(result, hasLength(1));
  expect(result.first.id, 'ivanov');
});

test('empty query returns all, sorted by name', () {
  final result = applyFilters(sample, query: '', verdict: null,
      sort: SortBy.name);
  expect(result.map((c) => c.name), isSorted);
});
```

## Cubit transitions with bloc_test

Assert the exact emitted state sequence — this is where reviewers look for "clean states".

```dart
class MockRepo extends Mock implements CandidateRepository {}

void main() {
  late MockRepo repo;
  setUp(() => repo = MockRepo());

  blocTest<CandidatesListCubit, CandidatesListState>(
    'emits [loading, loaded] when fetch succeeds',
    build: () {
      when(() => repo.getCandidates()).thenAnswer((_) async => sample);
      return CandidatesListCubit(repo);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const CandidatesListState.loading(),
      CandidatesListState.loaded(sample),
    ],
  );

  blocTest<CandidatesListCubit, CandidatesListState>(
    'emits [loading, error] when fetch throws',
    build: () {
      when(() => repo.getCandidates()).thenThrow(Exception('network'));
      return CandidatesListCubit(repo);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const CandidatesListState.loading(),
      isA<ErrorState>(),
    ],
  );
}
```

Add a test for the optimistic-update rollback: stub `updateStatus` to throw and assert the state returns to the previous status.

## Repository test with a mocked data source

Verify the offline fallback and the cache write — the core of task "offline":

```dart
test('returns cache when remote throws', () async {
  when(() => remote.fetch()).thenThrow(DioException(requestOptions: ro));
  when(() => local.getCached()).thenAnswer((_) async => sample);

  final result = await repository.getCandidates();

  expect(result, sample);
  expect(repository.isOffline, isTrue);
});

test('caches remote result on success', () async {
  when(() => remote.fetch()).thenAnswer((_) async => sample);
  when(() => local.cacheCandidates(any())).thenAnswer((_) async {});

  await repository.getCandidates();

  verify(() => local.cacheCandidates(sample)).called(1);
});
```

Register fallback values for non-primitive arguments used with `any()`:

```dart
setUpAll(() => registerFallbackValue(<Candidate>[]));
```

## Widget test for the list screen

Pump the screen with a stubbed cubit and assert rendering + a filter interaction + the empty state.

```dart
testWidgets('renders cards and filters by verdict', (tester) async {
  final cubit = MockListCubit();
  when(() => cubit.state).thenReturn(CandidatesListState.loaded(sample));

  await tester.pumpWidget(MaterialApp(
    home: BlocProvider<CandidatesListCubit>.value(
      value: cubit, child: const CandidatesListScreen()),
  ));

  expect(find.byType(CandidateCard), findsNWidgets(sample.length));

  await tester.tap(find.text('ПОДХОДИТ'));
  await tester.pump();
  verify(() => cubit.setVerdictFilter(Verdict.suitable)).called(1);
});

testWidgets('shows empty state when no results', (tester) async {
  final cubit = MockListCubit();
  when(() => cubit.state).thenReturn(const CandidatesListState.loaded([]));
  await tester.pumpWidget(/* ...as above... */);
  expect(find.byKey(const Key('empty-state')), findsOneWidget);
});
```

Give meaningful widgets stable `Key`s (e.g. `Key('empty-state')`, `Key('error-retry')`) so tests target them without brittle text matching.

## Edge cases to cover explicitly

- Empty list → empty-state widget, not a blank screen.
- Load error → error widget with a working retry.
- Missing/unknown candidate id → not-found screen (also a router test if time allows).
- Status update failure → UI rolls back and shows an error.

## Running

```bash
flutter test                       # all tests
flutter test --coverage            # generate coverage/lcov.info
flutter test test/foo_test.dart    # a single file while iterating
```

Mention coverage of the key logic in the README; aiming for >70% of the *logic* (not every widget) is a reasonable strong-middle target.