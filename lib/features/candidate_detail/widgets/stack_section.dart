import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';

class StackSection extends StatelessWidget {
  const StackSection(this.stack, {super.key});

  final String stack;

  @override
  Widget build(BuildContext context) {
    final skills = stack
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    if (skills.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Стек технологий'),
        const SizedBox(height: AppSpacing.x2),
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: AppRadius.cardBorderRadius,
            boxShadow: context.appColors.shadowSm,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.x3),
            child: Wrap(
              spacing: AppSpacing.x2,
              runSpacing: AppSpacing.x2,
              children: skills.map(_SkillTag.new).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _SkillTag extends StatelessWidget {
  const _SkillTag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest,
        borderRadius: AppRadius.tagBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.x3,
          vertical: AppSpacing.x1,
        ),
        child: Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: context.colors.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
