import 'package:flutter/material.dart';

import '../../../data/models/candidate.dart';

class StatusSelector extends StatelessWidget {
  const StatusSelector({
    required this.currentStatus,
    required this.isUpdating,
    required this.onChanged,
    super.key,
  });

  final String currentStatus;
  final bool isUpdating;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final status = CandidateStatus.fromValue(currentStatus);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Статус обработки', style: Theme.of(context).textTheme.titleMedium),
            if (isUpdating) ...[
              const SizedBox(width: 8),
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: CandidateStatus.values.map((s) {
            final isSelected = s == status;
            return ChoiceChip(
              label: Text(s.label),
              selected: isSelected,
              onSelected: isUpdating
                  ? null
                  : (_) {
                      if (!isSelected) onChanged(s.value);
                    },
            );
          }).toList(),
        ),
      ],
    );
  }
}
