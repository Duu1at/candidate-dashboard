import 'package:candidate_dashboard/data/data.dart';
import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

const _kOptions = [
  (null, 'Все', null),
  ('ПОДХОДИТ', 'ПОДХОДИТ', 'verdict-green'),
  ('ЧАСТИЧНО', 'ЧАСТИЧНО', 'verdict-orange'),
  ('НЕ ПОДХОДИТ', 'НЕ ПОДХОДИТ', 'verdict-red'),
];

class FilterChipsRow extends StatelessWidget {
  const FilterChipsRow({
    required this.selected,
    required this.onSelected,
    required this.allCandidates,
    super.key,
  });

  final String? selected;
  final ValueChanged<String?> onSelected;
  final List<CandidateModel> allCandidates;

  int _count(String? vc) {
    if (vc == null) return allCandidates.length;
    return allCandidates.where((c) => c.vc == vc).length;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.x5,
        AppSpacing.x3,
        AppSpacing.x5,
        AppSpacing.x3,
      ),
      child: Row(
        children: _kOptions.map((opt) {
          final (value, label, vc) = opt;
          final isSelected = selected == value;
          final count = _count(vc);
          final fg = isSelected
              ? context.colors.surface
              : context.colors.onSurfaceVariant;
          final countFg = isSelected
              ? context.colors.surface.withValues(alpha: 0.7)
              : context.colors.onSurfaceVariant.withValues(alpha: 0.7);

          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.x2),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: context.textTheme.labelMedium?.copyWith(color: fg),
                  ),
                  const SizedBox(width: AppSpacing.x2),
                  Text(
                    '$count',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: countFg,
                    ),
                  ),
                ],
              ),
              selected: isSelected,
              onSelected: (_) => onSelected(value),
              showCheckmark: false,
              selectedColor: context.colors.onSurface,
              backgroundColor: context.colors.surfaceContainerHighest,
              side: BorderSide.none,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          );
        }).toList(),
      ),
    );
  }
}
