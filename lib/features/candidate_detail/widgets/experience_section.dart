import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({required this.exp, super.key});

  final List<List<String>> exp;

  @override
  Widget build(BuildContext context) {
    if (exp.isEmpty) {
      return Text(
        'Нет опыта работы',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Опыт работы', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...exp.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return _ExpItem(
            period: item.elementAtOrNull(0) ?? '',
            company: item.elementAtOrNull(1) ?? '',
            role: item.elementAtOrNull(2) ?? '',
            duration: item.elementAtOrNull(3) ?? '',
            isLast: i == exp.length - 1,
          );
        }),
      ],
    );
  }
}

class _ExpItem extends StatelessWidget {
  const _ExpItem({
    required this.period,
    required this.company,
    required this.role,
    required this.duration,
    required this.isLast,
  });

  final String period;
  final String company;
  final String role;
  final String duration;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: cs.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: cs.outlineVariant,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(role, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(company, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        period,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                      ),
                      if (duration.isNotEmpty) ...[
                        Text(
                          ' • $duration',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
