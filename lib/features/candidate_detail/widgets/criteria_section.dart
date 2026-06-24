import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';

class CriteriaSection extends StatelessWidget {
  const CriteriaSection(this.criteria, {super.key});

  final List<List<String>> criteria;

  @override
  Widget build(BuildContext context) {
    if (criteria.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Критерии оценки'),
        const SizedBox(height: AppSpacing.x2),
        Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: ListTile.divideTiles(
              context: context,
              color: context.colors.surfaceContainerHighest,
              tiles: criteria.map((item) {
                final status = item.elementAtOrNull(0) ?? '';
                final palette = criteriaPalette(context, status);
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.x4,
                  ),
                  leading: CircleAvatar(
                    radius: 13,
                    backgroundColor: palette.background,
                    child: Icon(
                      criteriaIcon(status),
                      size: 15,
                      color: palette.foreground,
                    ),
                  ),
                  title: Text(
                    item.elementAtOrNull(1) ?? '',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.onSurface,
                    ),
                  ),
                );
              }),
            ).toList(),
          ),
        ),
      ],
    );
  }
}
