import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';

class QuestionsSection extends StatelessWidget {
  const QuestionsSection(this.questions, {super.key});

  final List<String> questions;

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Вопросы для собеседования'),
        const SizedBox(height: AppSpacing.x2),
        DecoratedBox(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: AppRadius.cardBorderRadius,
            boxShadow: context.appColors.shadowSm,
          ),
          child: Column(
            children: [
              for (int i = 0; i < questions.length; i++) ...[
                if (i != 0)
                  Divider(
                    height: 1,
                    indent: AppSpacing.x4,
                    endIndent: AppSpacing.x4,
                    color: context.colors.surfaceContainerHighest,
                  ),
                _QuestionItem(number: i + 1, text: questions[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _QuestionItem extends StatelessWidget {
  const _QuestionItem({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.x4,
        vertical: AppSpacing.x3,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: context.colors.surfaceContainerHighest,
            child: Text(
              '$number',
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colors.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.x3),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: AppSpacing.x1),
              child: Text(
                text,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
