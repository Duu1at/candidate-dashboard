import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';

class EducationSection extends StatelessWidget {
  const EducationSection(this.edu, {super.key});

  final String edu;

  @override
  Widget build(BuildContext context) {
    if (edu.isEmpty) return const SizedBox.shrink();

    final commaIndex = edu.indexOf(',');
    final institution = commaIndex > 0
        ? edu.substring(0, commaIndex).trim()
        : edu;
    final details = commaIndex > 0 ? edu.substring(commaIndex + 1).trim() : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Образование'),
        const SizedBox(height: AppSpacing.x2),
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: AppRadius.cardBorderRadius,
            boxShadow: context.appColors.shadowSm,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.x4),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.colors.surfaceContainerHighest,
                    borderRadius: AppRadius.buttonBorderRadius,
                  ),
                  child: const SizedBox(
                    width: 38,
                    height: 38,
                    child: Center(child: Icon(Icons.school_outlined, size: 20)),
                  ),
                ),
                const SizedBox(width: AppSpacing.x3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(institution, style: context.textTheme.titleSmall),
                      if (details.isNotEmpty)
                        Text(
                          details,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
