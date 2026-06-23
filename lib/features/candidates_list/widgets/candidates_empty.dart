import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

class CandidatesEmpty extends StatelessWidget {
  const CandidatesEmpty({
    required this.query,
    required this.onReset,
    super.key,
  });

  final String query;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final description = query.isNotEmpty
        ? 'По запросу «$query» нет кандидатов. '
              'Проверьте написание или сбросьте фильтры.'
        : 'Нет кандидатов, соответствующих выбранным фильтрам.';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.x8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: context.colors.outlineVariant,
            ),
            const SizedBox(height: AppSpacing.x6),
            Text('Ничего не найдено', style: context.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.x2),
            Text(
              description,
              textAlign: TextAlign.center,
              style: context.appTextStyles.muted.bodyMedium,
            ),
            const SizedBox(height: AppSpacing.x6),
            OutlinedButton(
              onPressed: onReset,
              child: const Text('Сбросить фильтры'),
            ),
          ],
        ),
      ),
    );
  }
}
