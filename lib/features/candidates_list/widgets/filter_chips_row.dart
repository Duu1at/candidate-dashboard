import 'package:flutter/material.dart';

const _verdicts = ['ПОДХОДИТ', 'ЧАСТИЧНО', 'НЕ ПОДХОДИТ'];

class FilterChipsRow extends StatelessWidget {
  const FilterChipsRow({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _chip(context, null, 'Все'),
          ..._verdicts.map((v) => _chip(context, v, v)),
        ],
      ),
    );
  }

  Widget _chip(BuildContext context, String? value, String label) {
    final isSelected = selected == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) => onSelected(value),
        showCheckmark: false,
      ),
    );
  }
}
