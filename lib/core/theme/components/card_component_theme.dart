import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

abstract final class CardComponentTheme {
  static CardThemeData build(ColorScheme colors) {
    return CardThemeData(
      color: colors.surface,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadius.cardBorderRadius,
      ),
      margin: EdgeInsets.zero,
    );
  }
}
