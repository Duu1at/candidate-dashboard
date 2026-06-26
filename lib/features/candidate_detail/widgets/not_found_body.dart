import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

class NotFoundBody extends StatelessWidget {
  const NotFoundBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 64,
            color: context.colors.outlineVariant,
          ),
          const SizedBox(height: AppSpacing.x4),
          Text('Кандидат не найден', style: context.textTheme.titleLarge),
        ],
      ),
    );
  }
}
