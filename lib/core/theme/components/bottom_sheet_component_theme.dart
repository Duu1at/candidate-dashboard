import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/theme/theme.dart';

abstract final class BottomSheetComponentTheme {
  static BottomSheetThemeData build(ColorScheme colors) {
    return BottomSheetThemeData(
      backgroundColor: colors.surface,
      surfaceTintColor: AppColors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.modalBorderRadius),
      showDragHandle: true,
      dragHandleColor: colors.outline,
    );
  }
}
