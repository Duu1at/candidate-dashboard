import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

class CandidatesError extends StatelessWidget {
  const CandidatesError({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.x8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: context.colors.error,
            ),
            const SizedBox(height: AppSpacing.x4),
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(height: AppSpacing.x4),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: context.colors.error,
              ),
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Повторить'),
            ),
          ],
        ),
      ),
    );
  }
}
