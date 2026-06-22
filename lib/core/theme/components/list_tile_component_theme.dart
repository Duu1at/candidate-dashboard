import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

abstract final class ListTileComponentTheme {
  static ListTileThemeData build(ColorScheme colors) {
    return ListTileThemeData(
      tileColor: AppColors.transparent,
      textColor: colors.onSurface,
      iconColor: colors.onSurfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.x4),
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.cardBorderRadius,
      ),
    );
  }
}
