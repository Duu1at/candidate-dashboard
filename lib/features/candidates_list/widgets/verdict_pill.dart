import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

const _kHPad = 10.0;
const _kVPad = 5.0;
const _kDotSize = 7.0;
const _kDotGap = 6.0;

class VerdictPill extends StatelessWidget {
  const VerdictPill({required this.vc, required this.verdict, super.key});

  final String vc;
  final String verdict;

  @override
  Widget build(BuildContext context) {
    final palette = verdictPalette(context, vc);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: palette.background,
        borderRadius: AppRadius.chipBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _kHPad,
          vertical: _kVPad,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: _kDotSize,
              height: _kDotSize,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: palette.dot,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: _kDotGap),
            Text(
              verdict,
              style: context.textTheme.labelSmall?.copyWith(
                color: palette.foreground,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
