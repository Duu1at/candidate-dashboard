import 'package:flutter/material.dart';

import '../../../core/utils/verdict_colors.dart';

class CriteriaSection extends StatelessWidget {
  const CriteriaSection({required this.criteria, super.key});

  final List<List<String>> criteria;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Критерии оценки',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ...criteria.map((item) {
          final status = item[0];
          final text = item[1];
          final color = criteriaColor(context, status);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(criteriaIcon(status), size: 18, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
