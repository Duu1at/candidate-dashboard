import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

abstract final class TooltipComponentTheme {
  static TooltipThemeData build(ColorScheme colors, TextTheme textTheme) {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: colors.inverseSurface,
        borderRadius: AppRadius.chipBorderRadius,
      ),
      textStyle: textTheme.labelMedium?.copyWith(
        color: colors.onInverseSurface,
      ),
    );
  }
}
