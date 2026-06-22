import 'package:flutter/material.dart';

import '../../../core/utils/verdict_colors.dart';
import '../../../data/models/candidate.dart';

class CandidateCard extends StatelessWidget {
  const CandidateCard({
    required this.candidate,
    required this.onTap,
    super.key,
  });

  final Candidate candidate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final status = CandidateStatus.fromValue(candidate.status);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      candidate.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _VerdictChip(vc: candidate.vc, verdict: candidate.verdict),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    candidate.city,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.work_outline_rounded,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    candidate.totalExp,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                candidate.stack,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              _StatusBadge(status: status),
            ],
          ),
        ),
      ),
    );
  }
}

class _VerdictChip extends StatelessWidget {
  const _VerdictChip({required this.vc, required this.verdict});

  final String vc;
  final String verdict;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: verdictContainerColor(context, vc),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        verdict,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: onVerdictContainerColor(context, vc),
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final CandidateStatus status;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = _colors(context, status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Text(
        status.label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: fg),
      ),
    );
  }

  (Color, Color) _colors(BuildContext context, CandidateStatus s) {
    final cs = Theme.of(context).colorScheme;
    return switch (s) {
      CandidateStatus.newCandidate => (cs.surfaceContainerHighest, cs.onSurfaceVariant),
      CandidateStatus.review => (cs.tertiaryContainer, cs.onTertiaryContainer),
      CandidateStatus.invited => (cs.secondaryContainer, cs.onSecondaryContainer),
      CandidateStatus.rejected => (cs.errorContainer, cs.onErrorContainer),
    };
  }
}
