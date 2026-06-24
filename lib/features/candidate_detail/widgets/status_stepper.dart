import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

class StatusStepper extends StatelessWidget {
  const StatusStepper({
    required this.statuses,
    required this.currentIndex,
    super.key,
  });

  final List<CandidateStatus> statuses;
  final int currentIndex;

  static String _shortLabel(CandidateStatus s) => switch (s) {
    CandidateStatus.newCandidate => 'Новый',
    CandidateStatus.review => 'Рассмотр.',
    CandidateStatus.invited => 'Приглашён',
    CandidateStatus.rejected => 'Отклонён',
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (i, status) in statuses.indexed) ...[
          _StepNode(
            label: _shortLabel(status),
            isPast: i < currentIndex,
            isCurrent: i == currentIndex,
          ),
          if (i < statuses.length - 1)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 9, bottom: AppSpacing.x5),
                child: Divider(
                  height: 2,
                  thickness: 2,
                  color: i < currentIndex
                      ? context.appColors.verdictGreen.dot
                      : context.colors.outlineVariant,
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class _StepNode extends StatelessWidget {
  const _StepNode({
    required this.label,
    required this.isPast,
    required this.isCurrent,
  });

  final String label;
  final bool isPast;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepCircle(isPast: isPast, isCurrent: isCurrent),
        const SizedBox(height: AppSpacing.x1),
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: isCurrent
                ? context.colors.primary
                : context.colors.onSurfaceVariant,
            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}

class _StepCircle extends StatelessWidget {
  const _StepCircle({required this.isPast, required this.isCurrent});

  final bool isPast;
  final bool isCurrent;

  static const _checkColor = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    if (isPast) {
      return CircleAvatar(
        radius: 10,
        backgroundColor: context.appColors.verdictGreen.dot,
        child: const Icon(Icons.check, size: 12, color: _checkColor),
      );
    }
    if (isCurrent) {
      return DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colors.primary,
          boxShadow: [
            BoxShadow(
              color: context.appColors.accentBlueSoft,
              spreadRadius: 4,
              blurRadius: 0,
            ),
          ],
        ),
        child: const SizedBox(width: 20, height: 20),
      );
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.surface,
        border: Border.all(color: context.colors.outlineVariant, width: 2),
      ),
      child: const SizedBox(width: 20, height: 20),
    );
  }
}
