import 'package:bloc_test/bloc_test.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CandidateFiltersCubit', () {
    test('initial state has empty query, null verdict, dateAdded sort', () {
      final cubit = CandidateFiltersCubit();
      expect(cubit.state.searchQuery, '');
      expect(cubit.state.verdictFilter, isNull);
      expect(cubit.state.sortBy, SortOption.dateAdded);
      cubit.close();
    });

    blocTest<CandidateFiltersCubit, CandidateFiltersState>(
      'search emits updated query',
      build: CandidateFiltersCubit.new,
      act: (c) => c.search('Иван'),
      expect: () => [
        const CandidateFiltersState(searchQuery: 'Иван'),
      ],
    );

    blocTest<CandidateFiltersCubit, CandidateFiltersState>(
      'filterByVerdict emits new verdict',
      build: CandidateFiltersCubit.new,
      act: (c) => c.filterByVerdict('verdict-green'),
      expect: () => [
        const CandidateFiltersState(verdictFilter: 'verdict-green'),
      ],
    );

    blocTest<CandidateFiltersCubit, CandidateFiltersState>(
      'filterByVerdict(null) clears the active verdict',
      build: CandidateFiltersCubit.new,
      seed: () => const CandidateFiltersState(verdictFilter: 'verdict-red'),
      act: (c) => c.filterByVerdict(null),
      expect: () => [
        const CandidateFiltersState(verdictFilter: null),
      ],
    );

    blocTest<CandidateFiltersCubit, CandidateFiltersState>(
      'setSortBy emits new sort option',
      build: CandidateFiltersCubit.new,
      act: (c) => c.setSortBy(SortOption.name),
      expect: () => [
        const CandidateFiltersState(sortBy: SortOption.name),
      ],
    );

    blocTest<CandidateFiltersCubit, CandidateFiltersState>(
      'reset restores initial state regardless of current values',
      build: CandidateFiltersCubit.new,
      seed: () => const CandidateFiltersState(
        searchQuery: 'query',
        verdictFilter: 'verdict-red',
        sortBy: SortOption.experience,
      ),
      act: (c) => c.reset(),
      expect: () => [const CandidateFiltersState()],
    );
  });
}
