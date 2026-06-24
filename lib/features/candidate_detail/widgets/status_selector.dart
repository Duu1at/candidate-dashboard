import 'package:flutter/material.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/core/core.dart';

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
              _StatusStepper(statuses: statuses, currentIndex: currentIndex),
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
        _StatusPill(status: status),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final CandidateStatus status;

  (Color, Color, Color) _colors(BuildContext context) => switch (status) {
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

  @override
  Widget build(BuildContext context) {
    final (bg, fg, dot) = _colors(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.chipBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.x3,
          vertical: AppSpacing.x1,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 3.5, backgroundColor: dot),
            const SizedBox(width: AppSpacing.x1 + 2),
            Text(
              status.label,
              style: context.textTheme.labelSmall?.copyWith(
                color: fg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusStepper extends StatelessWidget {
  const _StatusStepper({required this.statuses, required this.currentIndex});

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
        for (int i = 0; i < statuses.length; i++) ...[
          _StepNode(
            label: _shortLabel(statuses[i]),
            isPast: i < currentIndex,
            isCurrent: i == currentIndex,
          ),
          if (i < statuses.length - 1)
            Expanded(
              child: Padding(
                // 9 = circle_radius(10) − half_line(1): aligns connector to circle centre
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
      return Container(
        width: 20,
        height: 20,
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
      );
    }
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.surface,
        border: Border.all(color: context.colors.outlineVariant, width: 2),
      ),
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
