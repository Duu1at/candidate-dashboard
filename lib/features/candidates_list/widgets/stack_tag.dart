import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

class StackTag extends StatelessWidget {
  const StackTag(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      labelStyle: context.textTheme.labelSmall?.copyWith(
        color: context.colors.onSurfaceVariant,
      ),
      backgroundColor: context.colors.surfaceContainerHighest,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.tagBorderRadius,
      ),
      side: BorderSide.none,
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.x2),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
