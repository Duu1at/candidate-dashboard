import 'package:flutter/material.dart';

import '../../../core/utils/candidate_filter.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({
    required this.current,
    required this.onSelect,
    super.key,
  });

  final SortOption current;
  final ValueChanged<SortOption> onSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
            child: Text(
              'Сортировка',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          RadioGroup<SortOption>(
            groupValue: current,
            onChanged: (v) {
              if (v != null) {
                onSelect(v);
                Navigator.pop(context);
              }
            },
            child: Column(
              children: SortOption.values.map((option) {
                return RadioListTile<SortOption>(
                  title: Text(option.label),
                  value: option,
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
