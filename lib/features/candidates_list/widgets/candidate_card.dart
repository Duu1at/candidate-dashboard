import 'package:candidate_dashboard/data/data.dart';
import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';

const _kCardVerticalMargin = 6.0;
const _kDividerHeight = 14.0;

class CandidateCard extends StatelessWidget {
  const CandidateCard({
    required this.candidate,
    required this.onTap,
    super.key,
  });

  final Candidate candidate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.x4,
        vertical: _kCardVerticalMargin,
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: AppRadius.cardBorderRadius,
          boxShadow: context.appColors.shadowSm,
        ),
        child: InkWell(
          borderRadius: AppRadius.cardBorderRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.x4,
              vertical: AppSpacing.x3,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CardHeader(candidate),
                const SizedBox(height: AppSpacing.x3),
                _CardFooter(candidate),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader(this.candidate);

  final Candidate candidate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CandidateAvatar(candidate.name),
        const SizedBox(width: AppSpacing.x3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                candidate.name,
                style: context.textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 3),
              Text(
                '${candidate.city} · ${candidate.totalExp}',
                style: context.appTextStyles.muted.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.x2),
        VerdictPill(vc: candidate.vc, verdict: candidate.verdict),
      ],
    );
  }
}

class _CardFooter extends StatelessWidget {
  const _CardFooter(this.candidate);

  final Candidate candidate;

  @override
  Widget build(BuildContext context) {
    final status = CandidateStatus.fromValue(candidate.status);
    final tags = candidate.stack
        .split(', ')
        .where((t) => t.isNotEmpty)
        .toList();
    final visibleTags = tags.take(4).toList();
    final extra = tags.length - visibleTags.length;

    return Row(
      children: [
        StatusPill(status),
        const SizedBox(width: AppSpacing.x2),
        SizedBox(
          width: 1,
          height: _kDividerHeight,
          child: ColoredBox(color: context.colors.outlineVariant),
        ),
        const SizedBox(width: AppSpacing.x2),
        Expanded(
          child: Wrap(
            spacing: AppSpacing.x2,
            runSpacing: AppSpacing.x1,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ...visibleTags.map(StackTag.new),
              if (extra > 0)
                Text('+$extra', style: context.appTextStyles.muted.labelSmall),
            ],
          ),
        ),
      ],
    );
  }
}
