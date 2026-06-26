import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({
    required this.institution,
    required this.details,
    super.key,
  });

  final String institution;
  final String details;

  @override
  Widget build(BuildContext context) {
    if (institution.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Образование'),
        const SizedBox(height: AppSpacing.x2),
        Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            leading: DecoratedBox(
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
            title: Text(institution, style: context.textTheme.titleSmall),
            subtitle: details.isNotEmpty
                ? Text(
                    details,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
