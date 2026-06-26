import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

class StatusPill extends StatelessWidget {
  const StatusPill(this.status, {super.key});

  final CandidateStatus status;

  Color _dotColor(BuildContext context) => switch (status) {
    CandidateStatus.newCandidate => context.colors.primary,
    CandidateStatus.review => context.appColors.verdictOrange.dot,
    CandidateStatus.invited => context.appColors.verdictGreen.dot,
    CandidateStatus.rejected => context.appColors.verdictRed.dot,
  };

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(radius: 3.5, backgroundColor: _dotColor(context)),
      label: Text(
        status.label,
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colors.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: context.colors.surfaceContainerHighest,
      side: BorderSide.none,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.x1),
    );
  }
}
