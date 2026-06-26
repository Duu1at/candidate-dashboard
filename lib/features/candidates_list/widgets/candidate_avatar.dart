import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

class CandidateAvatar extends StatelessWidget {
  const CandidateAvatar(this.initials, {super.key});

  final String initials;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: context.colors.surfaceContainerHighest,
      child: Text(
        initials,
        style: context.textTheme.titleSmall?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),
      ),
    );
  }
}
