import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

class SkeletonCard extends StatefulWidget {
  const SkeletonCard({super.key});

  @override
  State<SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<SkeletonCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = context.colors.surfaceContainerHighest;
    final highlight = context.colors.outlineVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.x4,
        vertical: 6,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: AppRadius.cardBorderRadius,
          boxShadow: context.appColors.shadowSm,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.x4,
            vertical: AppSpacing.x3,
          ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, _) => _SkeletonContent(
              t: _controller.value,
              base: base,
              highlight: highlight,
            ),
          ),
        ),
      ),
    );
  }
}

class _SkeletonContent extends StatelessWidget {
  const _SkeletonContent({
    required this.t,
    required this.base,
    required this.highlight,
  });

  final double t;
  final Color base;
  final Color highlight;

  LinearGradient get _gradient => LinearGradient(
    begin: Alignment(-3 + t * 6, 0),
    end: Alignment(-1 + t * 6, 0),
    colors: [base, highlight, base],
  );

  Widget _bar(double w, double h, double radius) => SizedBox(
    width: w,
    height: h,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: _gradient,
      ),
    ),
  );

  Widget _circle(double size) => SizedBox(
    width: size,
    height: size,
    child: DecoratedBox(
      decoration: BoxDecoration(shape: BoxShape.circle, gradient: _gradient),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _circle(44),
            const SizedBox(width: AppSpacing.x3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bar(140, 14, 6),
                  const SizedBox(height: AppSpacing.x1),
                  _bar(90, 11, 6),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.x3),
            _bar(74, 22, AppRadius.chip),
          ],
        ),
        const SizedBox(height: AppSpacing.x3),
        Row(
          children: [
            _bar(120, 22, AppRadius.chip),
            const SizedBox(width: AppSpacing.x2),
            _bar(60, 22, AppRadius.tag),
            const SizedBox(width: AppSpacing.x2),
            _bar(46, 22, AppRadius.tag),
          ],
        ),
      ],
    );
  }
}
