import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candidate_dashboard/core/core.dart';

import '../cubit/candidates_list_cubit.dart';
import '../cubit/candidates_list_state.dart';
import 'candidate_card.dart';
import 'candidates_empty.dart';
import 'candidates_error.dart';
import 'skeleton_card.dart';

class CandidateListBody extends StatelessWidget {
  const CandidateListBody({
    required this.scrollController,
    required this.onReset,
    required this.onCardTap,
    super.key,
  });

  final ScrollController scrollController;
  final VoidCallback onReset;
  final ValueChanged<String> onCardTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CandidatesListCubit, CandidatesListState>(
      buildWhen: (a, b) =>
          a.status != b.status ||
          a.displayedCandidates != b.displayedCandidates ||
          a.filteredCandidates != b.filteredCandidates ||
          a.hasMore != b.hasMore ||
          a.searchQuery != b.searchQuery ||
          a.verdictFilter != b.verdictFilter,
      builder: (context, state) {
        return switch (state.status) {
          CandidatesListStatus.initial ||
          CandidatesListStatus.loading => ListView.builder(
            itemCount: 6,
            padding: const EdgeInsets.only(top: AppSpacing.x3),
            itemBuilder: (_, _) => const SkeletonCard(),
          ),
          CandidatesListStatus.error => CandidatesError(
            message: state.errorMessage ?? 'Неизвестная ошибка',
            onRetry: () {
              context.read<CandidatesListCubit>().load(forceRefresh: true);
            },
          ),
          CandidatesListStatus.loaded when state.filteredCandidates.isEmpty =>
            CandidatesEmpty(query: state.searchQuery, onReset: onReset),
          CandidatesListStatus.loaded => RefreshIndicator(
            onRefresh: () {
              return context.read<CandidatesListCubit>().load(
                forceRefresh: true,
              );
            },
            child: ListView.builder(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(
                top: AppSpacing.x3,
                bottom: AppSpacing.x4,
              ),
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
