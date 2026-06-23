import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';

class CandidateListBodySliver extends StatelessWidget {
  const CandidateListBodySliver({
    required this.onReset,
    required this.onCardTap,
    super.key,
  });

  final VoidCallback onReset;
  final ValueChanged<String> onCardTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandidatesListCubit, CandidatesListState>(
      buildWhen: (a, b) {
        return a.status != b.status ||
            a.displayedCandidates != b.displayedCandidates ||
            a.filteredCandidates != b.filteredCandidates ||
            a.hasMore != b.hasMore ||
            a.searchQuery != b.searchQuery ||
            a.verdictFilter != b.verdictFilter;
      },
      builder: (context, state) {
        return switch (state.status) {
          CandidatesListStatus.initial ||
          CandidatesListStatus.loading => SliverPadding(
            padding: const EdgeInsets.only(top: AppSpacing.x3),
            sliver: SliverList.builder(
              itemCount: 6,
              itemBuilder: (context, index) => const SkeletonCard(),
            ),
          ),
          CandidatesListStatus.error => SliverFillRemaining(
            child: CandidatesError(
              message: state.errorMessage ?? 'Неизвестная ошибка',
              onRetry: () =>
                  context.read<CandidatesListCubit>().load(forceRefresh: true),
            ),
          ),
          CandidatesListStatus.loaded when state.filteredCandidates.isEmpty =>
            SliverFillRemaining(
              child: CandidatesEmpty(
                query: state.searchQuery,
                onReset: onReset,
              ),
            ),
          CandidatesListStatus.loaded => SliverPadding(
            padding: const EdgeInsets.only(
              top: AppSpacing.x3,
              bottom: AppSpacing.x4,
            ),
            sliver: SliverList.builder(
              itemCount:
                  state.displayedCandidates.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.displayedCandidates.length) {
                  return const Padding(
                    padding: EdgeInsets.all(AppSpacing.x4),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final candidate = state.displayedCandidates[index];
                return CandidateCard(
                  key: ValueKey(candidate.id),
                  candidate: candidate,
                  onTap: () => onCardTap(candidate.id),
                );
              },
            ),
          ),
        };
      },
    );
  }
}
