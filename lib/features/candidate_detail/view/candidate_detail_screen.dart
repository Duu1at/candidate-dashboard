import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';

class CandidateDetailScreen extends StatelessWidget {
  const CandidateDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateDetailCubit, CandidateDetailState>(
      listenWhen: (a, b) =>
          a.errorMessage != b.errorMessage && b.errorMessage != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: context.colors.error,
          ),
        );
      },
      builder: (context, state) {
        return switch (state.status) {
          CandidateDetailStatus.loading || CandidateDetailStatus.initial =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
          CandidateDetailStatus.notFound => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_off_outlined,
                    size: 64,
                    color: context.colors.outlineVariant,
                  ),
                  const SizedBox(height: AppSpacing.x4),
                  Text(
                    'Кандидат не найден',
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          _ when state.candidate != null => _DetailView(state.candidate!),
          _ => const Scaffold(body: SizedBox.shrink()),
        };
      },
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView(this.candidate);

  final Candidate candidate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CandidateAppBar(candidate: candidate),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.x4),
            sliver: SliverList.list(
              children: [
                ContactButtons(candidate),
                const SizedBox(height: AppSpacing.x4),
                ExperienceSection(candidate.exp),
                const SizedBox(height: AppSpacing.x4),
                if (candidate.edu.isNotEmpty) ...[
                  EducationSection(candidate.edu),
                  const SizedBox(height: AppSpacing.x4),
                ],
                StackSection(candidate.stack),
                const SizedBox(height: AppSpacing.x4),
                CriteriaSection(candidate.criteria),
                const SizedBox(height: AppSpacing.x4),
                QuestionsSection(candidate.questions),
                const SizedBox(height: AppSpacing.x4),
                SummarySection(candidate.summary),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          BlocBuilder<CandidateDetailCubit, CandidateDetailState>(
            buildWhen: (a, b) {
              return a.candidate?.status != b.candidate?.status ||
                  a.status != b.status;
            },
            builder: (context, state) {
              return StatusSelector(
                currentStatus: state.candidate?.status ?? candidate.status,
                isUpdating:
                    state.status == CandidateDetailStatus.updatingStatus,
                onChanged: context.read<CandidateDetailCubit>().updateStatus,
              );
            },
          ),
    );
  }
}
