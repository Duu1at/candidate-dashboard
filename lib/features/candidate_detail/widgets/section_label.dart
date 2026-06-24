import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.x1),
      child: Text(
        text.toUpperCase(),
        style: context.textTheme.labelSmall?.copyWith(
          color: context.colors.onSurfaceVariant,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
