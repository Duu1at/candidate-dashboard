import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

class CandidateAvatar extends StatelessWidget {
  const CandidateAvatar(this.name, {super.key});

  final String name;

  static String _initials(String name) {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: context.colors.surfaceContainerHighest,
      child: Text(
        _initials(name),
        style: context.textTheme.titleSmall?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),
      ),
    );
  }
}
