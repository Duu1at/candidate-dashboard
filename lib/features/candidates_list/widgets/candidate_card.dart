import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

import '../../../core/utils/verdict_colors.dart';
import '../../../data/models/candidate.dart';

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
        vertical: 6,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: AppRadius.cardBorderRadius,
          boxShadow: context.appColors.shadowSm,
        ),
        child: ClipRRect(
          borderRadius: AppRadius.cardBorderRadius,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.x4,
                  vertical: AppSpacing.x3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CardHeader(candidate: candidate),
                    const SizedBox(height: AppSpacing.x3),
                    _CardFooter(candidate: candidate),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({required this.candidate});

  final Candidate candidate;

  static String _initials(String name) {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Avatar(initials: _initials(candidate.name)),
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
        _VerdictPill(vc: candidate.vc, verdict: candidate.verdict),
      ],
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.initials});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: context.colors.surfaceContainerHighest,
      child: Text(
        initials,
        style: context.textTheme.titleSmall?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),
      ),
    );
  }
}

class _VerdictPill extends StatelessWidget {
  const _VerdictPill({required this.vc, required this.verdict});

  final String vc;
  final String verdict;

  @override
  Widget build(BuildContext context) {
    final palette = verdictPalette(context, vc);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.background,
        borderRadius: AppRadius.chipBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 7,
              height: 7,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.dot,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              verdict,
              style: context.textTheme.labelSmall?.copyWith(
                color: palette.foreground,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardFooter extends StatelessWidget {
  const _CardFooter({required this.candidate});

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
        _StatusPill(status: status),
        const SizedBox(width: AppSpacing.x2),
        SizedBox(
          width: 1,
          height: 14,
          child: ColoredBox(color: context.colors.outlineVariant),
        ),
        const SizedBox(width: AppSpacing.x2),
        Expanded(
          child: Wrap(
            spacing: AppSpacing.x2,
            runSpacing: AppSpacing.x1,
            children: [
              ...visibleTags.map((t) => _StackTag(label: t)),
              if (extra > 0)
                Text('+$extra', style: context.appTextStyles.muted.labelSmall),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final CandidateStatus status;

  Color _dotColor(BuildContext context) => switch (status) {
    CandidateStatus.newCandidate => context.colors.primary,
    CandidateStatus.review => context.appColors.verdictOrange.dot,
    CandidateStatus.invited => context.appColors.verdictGreen.dot,
    CandidateStatus.rejected => context.appColors.statusRejected,
  };

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest,
        borderRadius: AppRadius.chipBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 7,
              height: 7,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _dotColor(context),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              status.label,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StackTag extends StatelessWidget {
  const _StackTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      labelStyle: context.textTheme.labelSmall?.copyWith(
        color: context.colors.onSurfaceVariant,
      ),
      backgroundColor: context.colors.surfaceContainerHighest,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.tagBorderRadius),
      side: BorderSide.none,
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.x2),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
