import 'package:flutter/material.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'status_stepper.dart';

class StatusSelector extends StatelessWidget {
  const StatusSelector({
    required this.currentStatus,
    required this.isUpdating,
    required this.onChanged,
    super.key,
  });

  final String currentStatus;
  final bool isUpdating;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final status = CandidateStatus.fromValue(currentStatus);
    final statuses = CandidateStatus.values;
    final currentIndex = statuses.indexOf(status);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: Border(top: BorderSide(color: context.colors.outlineVariant)),
        boxShadow: context.appColors.shadowLg,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.x4,
            AppSpacing.x3,
            AppSpacing.x4,
            AppSpacing.x4,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StatusHeader(status: status),
              const SizedBox(height: AppSpacing.x3),
              StatusStepper(statuses: statuses, currentIndex: currentIndex),
              const SizedBox(height: AppSpacing.x4),
              _ActionRow(
                status: status,
                isUpdating: isUpdating,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusHeader extends StatelessWidget {
  const _StatusHeader({required this.status});

  final CandidateStatus status;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, dot) = switch (status) {
      CandidateStatus.invited => (
        context.appColors.verdictGreen.background,
        context.appColors.verdictGreen.foreground,
        context.appColors.verdictGreen.dot,
      ),
      CandidateStatus.rejected => (
        context.appColors.verdictRed.background,
        context.appColors.verdictRed.foreground,
        context.appColors.verdictRed.dot,
      ),
      CandidateStatus.review => (
        context.appColors.verdictOrange.background,
        context.appColors.verdictOrange.foreground,
        context.appColors.verdictOrange.dot,
      ),
      CandidateStatus.newCandidate => (
        context.colors.primaryContainer,
        context.colors.onPrimaryContainer,
        context.colors.primary,
      ),
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'СТАТУС ОБРАБОТКИ',
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colors.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        Chip(
          avatar: CircleAvatar(radius: 3.5, backgroundColor: dot),
          label: Text(
            status.label,
            style: context.textTheme.labelSmall?.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: bg,
          side: BorderSide.none,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.x1),
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.status,
    required this.isUpdating,
    required this.onChanged,
  });

  final CandidateStatus status;
  final bool isUpdating;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final canInvite = !isUpdating && status != CandidateStatus.invited;
    final canReject = !isUpdating && status != CandidateStatus.rejected;

    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: canInvite
                ? () => onChanged(CandidateStatus.invited.value)
                : null,
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: isUpdating
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.colors.onPrimary,
                    ),
                  )
                : const Text('Пригласить на собеседование'),
          ),
        ),
        const SizedBox(width: AppSpacing.x3),
        SizedBox(
          width: 50,
          height: 50,
          child: OutlinedButton(
            onPressed: canReject
                ? () => onChanged(CandidateStatus.rejected.value)
                : null,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              side: BorderSide(color: context.colors.errorContainer),
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadius.ctaBorderRadius,
              ),
            ),
            child: Icon(Icons.close, color: context.colors.error),
          ),
        ),
      ],
    );
  }
}
