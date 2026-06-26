import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';

class StackSection extends StatelessWidget {
  const StackSection(this.stackTags, {super.key});

  final List<String> stackTags;

  @override
  Widget build(BuildContext context) {
    if (stackTags.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Стек технологий'),
        const SizedBox(height: AppSpacing.x2),
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.x3),
            child: Wrap(
              spacing: AppSpacing.x2,
              runSpacing: AppSpacing.x2,
              children: stackTags
                  .map(
                    (skill) => Chip(
                      label: Text(
                        skill,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colors.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: context.colors.surfaceContainerHighest,
                      side: BorderSide.none,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
