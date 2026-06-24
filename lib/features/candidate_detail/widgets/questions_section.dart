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
        Card(
          margin: EdgeInsets.zero,
          child: Column(
            children: ListTile.divideTiles(
              context: context,
              color: context.colors.surfaceContainerHighest,
              tiles: questions.indexed.map((record) {
                final (i, question) = record;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.x4,
                  ),
                  leading: CircleAvatar(
                    radius: 12,
                    backgroundColor: context.colors.surfaceContainerHighest,
                    child: Text(
                      '${i + 1}',
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colors.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  title: Text(
                    question,
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
