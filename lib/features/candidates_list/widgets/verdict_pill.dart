import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

class VerdictPill extends StatelessWidget {
  const VerdictPill({required this.vc, required this.verdict, super.key});

  final String vc;
  final String verdict;

  @override
  Widget build(BuildContext context) {
    final palette = context.appColors.verdictPalette(vc);
    return Chip(
      avatar: CircleAvatar(radius: 3.5, backgroundColor: palette.dot),
      label: Text(
        verdict,
        style: context.textTheme.labelSmall?.copyWith(
          color: palette.foreground,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
      backgroundColor: palette.background,
      side: BorderSide.none,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.x1),
    );
  }
}
