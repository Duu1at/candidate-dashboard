import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection(this.exp, {super.key});

  final List<List<String>> exp;

  @override
  Widget build(BuildContext context) {
    if (exp.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Опыт работы'),
        const SizedBox(height: AppSpacing.x2),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.x4),
            child: Column(
              children: ListTile.divideTiles(
                context: context,
                color: context.colors.surfaceContainerHighest,
                tiles: exp.indexed.map((record) {
                  final (i, entry) = record;
                  return _ExpEntry(
                    entry: entry,
                    isFirst: i == 0,
                    isLast: i == exp.length - 1,
                  );
                }),
              ).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ExpEntry extends StatelessWidget {
  const _ExpEntry({
    required this.entry,
    required this.isFirst,
    required this.isLast,
  });

  final List<String> entry;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final period = entry.elementAtOrNull(0) ?? '';
    final company = entry.elementAtOrNull(1) ?? '';
    final role = entry.elementAtOrNull(2) ?? '';
    final duration = entry.elementAtOrNull(3) ?? '';

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 9,
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.x3 + 2),
                CircleAvatar(
                  radius: 4.5,
                  backgroundColor: isFirst
                      ? context.colors.primary
                      : context.colors.outlineVariant,
                ),
                if (!isLast)
                  Expanded(
                    child: VerticalDivider(
                      width: 2,
                      color: context.colors.outlineVariant,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.x3),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.x3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    period,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.x1),
                  Text(company, style: context.textTheme.bodyLarge),
                  const SizedBox(height: AppSpacing.x1),
                  Text(
                    role,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (duration.isNotEmpty) ...[
            const SizedBox(width: AppSpacing.x2),
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.x3),
              child: Chip(
                label: Text(
                  duration,
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
              ),
            ),
          ],
        ],
      ),
    );
  }
}
