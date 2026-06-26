import 'package:candidate_dashboard/core/core.dart';
import 'package:flutter/material.dart';

class ErrorBody extends StatelessWidget {
  const ErrorBody({
    required this.onRetry,
    this.message,
    super.key,
  });

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.x6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              size: 64,
              color: context.colors.outlineVariant,
            ),
            const SizedBox(height: AppSpacing.x4),
            Text(
              message ?? 'Не удалось загрузить кандидата.',
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.x6),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Попробовать снова'),
            ),
          ],
        ),
      ),
    );
  }
}
