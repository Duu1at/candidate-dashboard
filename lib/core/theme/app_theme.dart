import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

abstract final class AppTheme {
  static ThemeData get light => _build(
    colors: AppColorSchemes.light,
    appColors: AppColorsExt.light,
    scaffoldBackground: AppColors.iosGray,
  );

  static ThemeData get dark => _build(
    colors: AppColorSchemes.dark,
    appColors: AppColorsExt.dark,
    scaffoldBackground: AppColors.dark900,
  );

  static ThemeData _build({
    required ColorScheme colors,
    required AppColorsExt appColors,
    required Color scaffoldBackground,
  }) {
    final appTextTheme = AppTextTheme.from(colors.onSurface);
    final textTheme = appTextTheme.toMaterialTextTheme();
    final textThemeExt = AppTextThemeExt.from(colors: colors);

    return ThemeData(
      useMaterial3: true,
      brightness: colors.brightness,
      colorScheme: colors,
      scaffoldBackgroundColor: scaffoldBackground,
      fontFamily: 'Inter',
      textTheme: textTheme,
      extensions: [appColors, textThemeExt],
      floatingActionButtonTheme: FloatingActionButtonComponentTheme.build(
        colors,
        textTheme,
      ),
      appBarTheme: AppBarComponentTheme.build(colors, textTheme),
      cardTheme: CardComponentTheme.build(colors),
      filledButtonTheme: ButtonComponentTheme.filled(colors, textTheme),
      elevatedButtonTheme: ButtonComponentTheme.elevated(colors, textTheme),
      outlinedButtonTheme: ButtonComponentTheme.outlined(colors, textTheme),
      textButtonTheme: ButtonComponentTheme.text(colors, textTheme),
      inputDecorationTheme: InputComponentTheme.build(colors, textTheme),
      bottomSheetTheme: BottomSheetComponentTheme.build(colors),
      dialogTheme: DialogComponentTheme.build(colors, textTheme),
      chipTheme: ChipComponentTheme.build(colors, textTheme),
      dividerTheme: DividerComponentTheme.build(colors),
      snackBarTheme: SnackbarComponentTheme.build(colors, textTheme),
      listTileTheme: ListTileComponentTheme.build(colors),
      switchTheme: SwitchComponentTheme.build(colors),
      progressIndicatorTheme: ProgressIndicatorComponentTheme.build(colors),
      navigationBarTheme: NavigationBarComponentTheme.build(
        colors,
        textTheme,
        appColors,
      ),
      popupMenuTheme: PopupMenuComponentTheme.build(colors, textTheme),
      tooltipTheme: TooltipComponentTheme.build(colors, textTheme),
    );
  }
}
