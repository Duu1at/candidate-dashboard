import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

const _kHPad = 10.0;
const _kVPad = 4.0;
const _kDotSize = 7.0;
const _kDotGap = 6.0;

class StatusPill extends StatelessWidget {
  const StatusPill(this.status, {super.key});

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
        padding: const EdgeInsets.symmetric(
          horizontal: _kHPad,
          vertical: _kVPad,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: _kDotSize,
              height: _kDotSize,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: _dotColor(context),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: _kDotGap),
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
