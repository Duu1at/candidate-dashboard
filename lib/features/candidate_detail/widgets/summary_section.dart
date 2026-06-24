import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';


class SummarySection extends StatelessWidget {
  const SummarySection(this.summary, {super.key});

  final String summary;

  @override
  Widget build(BuildContext context) {
    if (summary.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Summary'),
        const SizedBox(height: AppSpacing.x2),
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: AppRadius.cardBorderRadius,
            boxShadow: context.appColors.shadowSm,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.x4),
            child: Text(
              summary,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colors.onSurface,
                height: 1.6,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
