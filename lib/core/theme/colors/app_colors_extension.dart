import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

@immutable
final class VerdictPalette {
  const VerdictPalette({
    required this.background,
    required this.foreground,
    required this.dot,
  });

  final Color background;
  final Color foreground;
  final Color dot;

  VerdictPalette _lerp(VerdictPalette other, double t) {
    return VerdictPalette(
    background: Color.lerp(background, other.background, t)!,
    foreground: Color.lerp(foreground, other.foreground, t)!,
    dot: Color.lerp(dot, other.dot, t)!,
  );
  }
}

@immutable
final class AppColorsExt extends ThemeExtension<AppColorsExt> {
  const AppColorsExt({
    required this.verdictGreen,
    required this.verdictOrange,
    required this.verdictRed,
    required this.statusRejected,
    required this.offlineBannerBg,
    required this.offlineBannerText,
    required this.accentBlueSoft,
    required this.shadowSm,
    required this.shadowMd,
    required this.shadowLg,
  });

  final VerdictPalette verdictGreen;
  final VerdictPalette verdictOrange;
  final VerdictPalette verdictRed;
  final Color statusRejected;
  final Color offlineBannerBg;
  final Color offlineBannerText;
  final Color accentBlueSoft;
  final List<BoxShadow> shadowSm;
  final List<BoxShadow> shadowMd;
  final List<BoxShadow> shadowLg;

  static const AppColorsExt light = AppColorsExt(
    verdictGreen: VerdictPalette(
      background: AppColors.verdictGreenLight,
      foreground: AppColors.verdictGreenDark,
      dot: AppColors.verdictGreen,
    ),
    verdictOrange: VerdictPalette(
      background: AppColors.verdictOrangeLight,
      foreground: AppColors.verdictOrangeDark,
      dot: AppColors.verdictOrange,
    ),
    verdictRed: VerdictPalette(
      background: AppColors.verdictRedLight,
      foreground: AppColors.verdictRedDark,
      dot: AppColors.verdictRed,
    ),
    statusRejected: AppColors.slate400,
    offlineBannerBg: AppColors.verdictOrangeLight,
    offlineBannerText: AppColors.offlineTextAmber,
    accentBlueSoft: AppColors.accentBlueSoftLight,
    shadowSm: AppShadow.smLight,
    shadowMd: AppShadow.mdLight,
    shadowLg: AppShadow.lgLight,
  );

  static const AppColorsExt dark = AppColorsExt(
    verdictGreen: VerdictPalette(
      background: AppColors.verdictGreenSoft,
      foreground: AppColors.verdictGreenMod,
      dot: AppColors.verdictGreen,
    ),
    verdictOrange: VerdictPalette(
      background: AppColors.verdictOrangeSoft,
      foreground: AppColors.verdictOrangeMod,
      dot: AppColors.verdictOrange,
    ),
    verdictRed: VerdictPalette(
      background: AppColors.verdictRedSoft,
      foreground: AppColors.verdictRedMod,
      dot: AppColors.verdictRed,
    ),
    statusRejected: AppColors.slate400,
    offlineBannerBg: AppColors.verdictOrangeSoft,
    offlineBannerText: AppColors.verdictOrangeMod,
    accentBlueSoft: AppColors.accentBlueSoftDark,
    shadowSm: AppShadow.smDark,
    shadowMd: AppShadow.mdDark,
    shadowLg: AppShadow.lgDark,
  );

  @override
  AppColorsExt copyWith({
    VerdictPalette? verdictGreen,
    VerdictPalette? verdictOrange,
    VerdictPalette? verdictRed,
    Color? statusRejected,
    Color? offlineBannerBg,
    Color? offlineBannerText,
    Color? accentBlueSoft,
    List<BoxShadow>? shadowSm,
    List<BoxShadow>? shadowMd,
    List<BoxShadow>? shadowLg,
  }) {
    return AppColorsExt(
      verdictGreen: verdictGreen ?? this.verdictGreen,
      verdictOrange: verdictOrange ?? this.verdictOrange,
      verdictRed: verdictRed ?? this.verdictRed,
      statusRejected: statusRejected ?? this.statusRejected,
      offlineBannerBg: offlineBannerBg ?? this.offlineBannerBg,
      offlineBannerText: offlineBannerText ?? this.offlineBannerText,
      accentBlueSoft: accentBlueSoft ?? this.accentBlueSoft,
      shadowSm: shadowSm ?? this.shadowSm,
      shadowMd: shadowMd ?? this.shadowMd,
      shadowLg: shadowLg ?? this.shadowLg,
    );
  }

  @override
  AppColorsExt lerp(ThemeExtension<AppColorsExt>? other, double t) {
    if (other is! AppColorsExt) return this;
    return AppColorsExt(
      verdictGreen: verdictGreen._lerp(other.verdictGreen, t),
      verdictOrange: verdictOrange._lerp(other.verdictOrange, t),
      verdictRed: verdictRed._lerp(other.verdictRed, t),
      statusRejected: Color.lerp(statusRejected, other.statusRejected, t)!,
      offlineBannerBg: Color.lerp(offlineBannerBg, other.offlineBannerBg, t)!,
      offlineBannerText: Color.lerp(
        offlineBannerText,
        other.offlineBannerText,
        t,
      )!,
      accentBlueSoft: Color.lerp(accentBlueSoft, other.accentBlueSoft, t)!,
      shadowSm: t < 0.5 ? shadowSm : other.shadowSm,
      shadowMd: t < 0.5 ? shadowMd : other.shadowMd,
      shadowLg: t < 0.5 ? shadowLg : other.shadowLg,
    );
  }
}
