import 'package:flutter/material.dart';

@immutable
final class AppTextTheme {
  const AppTextTheme({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.amountSmall,
  });

  factory AppTextTheme.from(Color color) {
    return AppTextTheme(
      displayLarge: _style(
        48,
        56,
        FontWeight.w700,
        tabular: true,
        color: color,
      ),
      displayMedium: _style(
        40,
        48,
        FontWeight.w700,
        tabular: true,
        color: color,
      ),
      displaySmall: _style(
        32,
        40,
        FontWeight.w700,
        tabular: true,
        color: color,
      ),
      headlineLarge: _style(27, 33, FontWeight.w700, color: color),
      headlineMedium: _style(20, 26, FontWeight.w700, color: color),
      headlineSmall: _style(18, 24, FontWeight.w600, color: color),
      titleLarge: _style(16, 22, FontWeight.w600, color: color),
      titleMedium: _style(16, 22, FontWeight.w600, color: color),
      titleSmall: _style(14, 20, FontWeight.w600, color: color),
      bodyLarge: _style(15, 22, FontWeight.w600, color: color),
      bodyMedium: _style(14, 22, FontWeight.w400, color: color),
      bodySmall: _style(13, 18, FontWeight.w500, color: color),
      labelLarge: _style(15, 20, FontWeight.w600, color: color),
      labelMedium: _style(13, 18, FontWeight.w600, color: color),
      labelSmall: _style(12, 16, FontWeight.w500, color: color),
      amountSmall: _style(24, 32, FontWeight.w700, tabular: true, color: color),
    );
  }

  factory AppTextTheme.lerp(AppTextTheme a, AppTextTheme b, double t) {
    return AppTextTheme(
      displayLarge: TextStyle.lerp(a.displayLarge, b.displayLarge, t)!,
      displayMedium: TextStyle.lerp(a.displayMedium, b.displayMedium, t)!,
      displaySmall: TextStyle.lerp(a.displaySmall, b.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(a.headlineLarge, b.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(a.headlineMedium, b.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(a.headlineSmall, b.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(a.titleLarge, b.titleLarge, t)!,
      titleMedium: TextStyle.lerp(a.titleMedium, b.titleMedium, t)!,
      titleSmall: TextStyle.lerp(a.titleSmall, b.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(a.bodyLarge, b.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(a.bodyMedium, b.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(a.bodySmall, b.bodySmall, t)!,
      labelLarge: TextStyle.lerp(a.labelLarge, b.labelLarge, t)!,
      labelMedium: TextStyle.lerp(a.labelMedium, b.labelMedium, t)!,
      labelSmall: TextStyle.lerp(a.labelSmall, b.labelSmall, t)!,
      amountSmall: TextStyle.lerp(a.amountSmall, b.amountSmall, t)!,
    );
  }

  /// 48 / 56 · w700
  final TextStyle displayLarge;

  /// 40 / 48 · w700
  final TextStyle displayMedium;

  /// 32 / 40 · w700
  final TextStyle displaySmall;

  /// 27 / 33 · w700
  final TextStyle headlineLarge;

  /// 20 / 26 · w700
  final TextStyle headlineMedium;

  /// 18 / 24 · w600
  final TextStyle headlineSmall;

  /// 16 / 22 · w600
  final TextStyle titleLarge;

  /// 16 / 22 · w600
  final TextStyle titleMedium;

  /// 14 / 20 · w600
  final TextStyle titleSmall;

  /// 15 / 22 · w600
  final TextStyle bodyLarge;

  /// 14 / 22 · w400
  final TextStyle bodyMedium;

  /// 13 / 18 · w500
  final TextStyle bodySmall;

  /// 15 / 20 · w600
  final TextStyle labelLarge;

  /// 13 / 18 · w600
  final TextStyle labelMedium;

  /// 12 / 16 · w500
  final TextStyle labelSmall;

  /// 24 / 32 · w700
  final TextStyle amountSmall;

  TextTheme toMaterialTextTheme() {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }

  static TextStyle _style(
    double size,
    double height,
    FontWeight weight, {
    required Color color,
    bool tabular = false,
  }) {
    return TextStyle(
      color: color,
      fontSize: size,
      height: height / size,
      fontWeight: weight,
      fontFamily: 'Inter',
      fontFeatures: tabular ? const [FontFeature.tabularFigures()] : null,
    );
  }
}
