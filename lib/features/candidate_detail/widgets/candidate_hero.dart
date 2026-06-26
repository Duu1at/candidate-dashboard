import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

class CandidateHero extends StatelessWidget {
  const CandidateHero(this.candidate, {super.key});

  final CandidateModel candidate;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: AppRadius.cardBorderRadius,
        boxShadow: context.appColors.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.x4,
            ),
            leading: CircleAvatar(
              radius: 31,
              backgroundColor: context.colors.surfaceContainerHighest,
              child: Text(
                candidate.initials,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: context.colors.onSurfaceVariant,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            title: Text(
              candidate.name,
              style: context.textTheme.headlineSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              candidate.posLabel,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.x2),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.x4,
              vertical: AppSpacing.x2,
            ),
            child: Row(
              children: [
                Chip(
                  avatar: CircleAvatar(
                    radius: 4,
                    backgroundColor: context.appColors.verdictColor(candidate.vc),
                  ),
                  label: Text(
                    candidate.verdict,
                    style: context.textTheme.labelMedium?.copyWith(
                      color: context.appColors.onVerdictContainerColor(candidate.vc),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                  backgroundColor: context.appColors.verdictContainerColor(candidate.vc),
                  side: BorderSide.none,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.x1,
                  ),
                ),
                const SizedBox(width: AppSpacing.x3),
                Expanded(
                  child: Text(
                    '${candidate.city} · ${candidate.totalExp}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
