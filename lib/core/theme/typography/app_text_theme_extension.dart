import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

@immutable
final class AppTextThemeExt extends ThemeExtension<AppTextThemeExt> {
  const AppTextThemeExt({
    required this.error,
    required this.disabled,
    required this.muted,
    required this.onPrimary,
    required this.link,
  });

  factory AppTextThemeExt.from({required ColorScheme colors}) {
    return AppTextThemeExt(
      error: AppTextTheme.from(colors.error),
      disabled: AppTextTheme.from(
        colors.onSurface.withValues(alpha: AppOpacity.disabledForeground),
      ),
      muted: AppTextTheme.from(colors.onSurfaceVariant),
      onPrimary: AppTextTheme.from(colors.onPrimary),
      link: AppTextTheme.from(colors.primary).bodyMedium.copyWith(
        decoration: TextDecoration.underline,
        decorationColor: colors.primary,
      ),
    );
  }

  final AppTextTheme error;
  final AppTextTheme disabled;
  final AppTextTheme muted;
  final AppTextTheme onPrimary;
  final TextStyle link;

  @override
  AppTextThemeExt copyWith({
    AppTextTheme? error,
    AppTextTheme? disabled,
    AppTextTheme? muted,
    AppTextTheme? onPrimary,
    TextStyle? link,
  }) {
    return AppTextThemeExt(
      error: error ?? this.error,
      disabled: disabled ?? this.disabled,
      muted: muted ?? this.muted,
      onPrimary: onPrimary ?? this.onPrimary,
      link: link ?? this.link,
    );
  }

  @override
  AppTextThemeExt lerp(ThemeExtension<AppTextThemeExt>? other, double t) {
    if (other is! AppTextThemeExt) return this;
    return AppTextThemeExt(
      error: AppTextTheme.lerp(error, other.error, t),
      disabled: AppTextTheme.lerp(disabled, other.disabled, t),
      muted: AppTextTheme.lerp(muted, other.muted, t),
      onPrimary: AppTextTheme.lerp(onPrimary, other.onPrimary, t),
      link: TextStyle.lerp(link, other.link, t)!,
    );
  }
}
