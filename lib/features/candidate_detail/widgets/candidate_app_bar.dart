import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';

class CandidateAppBar extends StatelessWidget {
  const CandidateAppBar({required this.candidate, super.key});

  final Candidate candidate;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 200,
      leading: _CircleIconButton(
        icon: Icons.arrow_back_ios_new,
        iconSize: 18,
        onPressed: () => context.pop(),
      ),
      title: const Text('Кандидат'),
      centerTitle: true,
      actions: [
        _CircleIconButton(
          icon: Icons.more_horiz,
          iconSize: 20,
          onPressed: () {},
        ),
        const SizedBox(width: AppSpacing.x2),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: _CandidateHero(candidate: candidate),
        collapseMode: CollapseMode.pin,
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.iconSize,
    required this.onPressed,
  });

  final IconData icon;
  final double iconSize;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: iconSize),
      style: IconButton.styleFrom(
        backgroundColor: context.colors.surfaceContainerHighest,
        shape: const CircleBorder(),
        minimumSize: const Size(38, 38),
      ),
      onPressed: onPressed,
    );
  }
}

class _CandidateHero extends StatelessWidget {
  const _CandidateHero({required this.candidate});

  final Candidate candidate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.x4,
        kToolbarHeight + AppSpacing.x2,
        AppSpacing.x4,
        AppSpacing.x4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _InitialsAvatar(candidate.name),
              const SizedBox(width: AppSpacing.x4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.name,
                      style: context.textTheme.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.x1),
                    Text(
                      candidate.posLabel,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.x3),
          Row(
            children: [
              _VerdictBadge(vc: candidate.vc, verdict: candidate.verdict),
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
        ],
      ),
    );
  }
}

class _InitialsAvatar extends StatelessWidget {
  const _InitialsAvatar(this.name);

  final String name;

  String get _initials {
    final words = name.trim().split(RegExp(r'\s+'));
    if (words.length >= 2) return '${words[0][0]}${words[1][0]}';
    return words.first.isNotEmpty ? words.first[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 31,
      backgroundColor: context.colors.surfaceContainerHighest,
      child: Text(
        _initials,
        style: context.textTheme.headlineSmall?.copyWith(
          color: context.colors.onSurfaceVariant,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _VerdictBadge extends StatelessWidget {
  const _VerdictBadge({required this.vc, required this.verdict});

  final String vc;
  final String verdict;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: verdictContainerColor(context, vc),
        borderRadius: AppRadius.chipBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.x3,
          vertical: AppSpacing.x2,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 4, backgroundColor: verdictColor(context, vc)),
            const SizedBox(width: AppSpacing.x2),
            Text(
              verdict,
              style: context.textTheme.labelMedium?.copyWith(
                color: onVerdictContainerColor(context, vc),
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
