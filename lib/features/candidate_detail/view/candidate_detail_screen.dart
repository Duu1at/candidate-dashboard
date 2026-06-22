import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/verdict_colors.dart';
import '../../../data/models/candidate.dart';
import '../cubit/candidate_detail_cubit.dart';
import '../cubit/candidate_detail_state.dart';
import '../widgets/contact_row.dart';
import '../widgets/criteria_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/status_selector.dart';

class CandidateDetailScreen extends StatelessWidget {
  const CandidateDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CandidateDetailCubit, CandidateDetailState>(
      listenWhen: (a, b) => a.errorMessage != b.errorMessage && b.errorMessage != null,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      },
      builder: (context, state) => switch (state.status) {
        CandidateDetailStatus.loading || CandidateDetailStatus.initial => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        CandidateDetailStatus.notFound => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person_off_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Кандидат не найден',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
        _ when state.candidate != null => _DetailView(candidate: state.candidate!),
        _ => const Scaffold(body: SizedBox.shrink()),
      },
    );
  }
}

class _DetailView extends StatelessWidget {
  const _DetailView({required this.candidate});

  final Candidate candidate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _AppBar(candidate: candidate),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _ContactsSection(candidate: candidate),
                const _Divider(),
                BlocBuilder<CandidateDetailCubit, CandidateDetailState>(
                  buildWhen: (a, b) =>
                      a.candidate?.status != b.candidate?.status ||
                      a.status != b.status,
                  builder: (context, state) => StatusSelector(
                    currentStatus: state.candidate?.status ?? candidate.status,
                    isUpdating: state.status == CandidateDetailStatus.updatingStatus,
                    onChanged: context.read<CandidateDetailCubit>().updateStatus,
                  ),
                ),
                const _Divider(),
                _SummarySection(summary: candidate.summary),
                const _Divider(),
                CriteriaSection(criteria: candidate.criteria),
                const _Divider(),
                ExperienceSection(exp: candidate.exp),
                const _Divider(),
                _StackSection(stack: candidate.stack, edu: candidate.edu),
                const _Divider(),
                _QuestionsSection(questions: candidate.questions),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({required this.candidate});

  final Candidate candidate;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              candidate.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(32),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Row(
            children: [
              _VerdictBadge(vc: candidate.vc, verdict: candidate.verdict),
              const SizedBox(width: 8),
              Text(
                candidate.posLabel,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerdictBadge extends StatelessWidget {
  const _VerdictBadge({required this.vc, required this.verdict});

  final String vc;
  final String verdict;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: verdictContainerColor(context, vc),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        verdict,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: onVerdictContainerColor(context, vc),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _ContactsSection extends StatelessWidget {
  const _ContactsSection({required this.candidate});

  final Candidate candidate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Контакты', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (candidate.phone.isNotEmpty)
          ContactRow(
            icon: Icons.phone_outlined,
            label: candidate.phone,
            url: 'tel:${candidate.phone}',
          ),
        if (candidate.email.isNotEmpty)
          ContactRow(
            icon: Icons.email_outlined,
            label: candidate.email,
            url: 'mailto:${candidate.email}',
          ),
        if (candidate.tg.isNotEmpty)
          ContactRow(
            icon: Icons.telegram,
            label: candidate.tg,
            url: 'https://t.me/${candidate.tg.replaceFirst('@', '')}',
          ),
        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 18),
            const SizedBox(width: 10),
            Text(candidate.city, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Summary', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(summary, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ],
    );
  }
}

class _StackSection extends StatelessWidget {
  const _StackSection({required this.stack, required this.edu});

  final String stack;
  final String edu;

  @override
  Widget build(BuildContext context) {
    final skills = stack.split(',').map((s) => s.trim()).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Стек и образование', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: skills
              .map(
                (s) => Chip(
                  label: Text(s),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
              )
              .toList(),
        ),
        if (edu.isNotEmpty) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.school_outlined,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  edu,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _QuestionsSection extends StatelessWidget {
  const _QuestionsSection({required this.questions});

  final List<String> questions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Вопросы для собеседования', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...questions.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${e.key + 1}.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        e.value,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) =>
      const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider());
}
