import 'package:flutter/material.dart';

/// Single source of truth for every raw color token used in the app.
///
/// Access patterns:
/// - `colorScheme.X`   → semantic Material slots (see comments below)
/// - `context.appColors.verdictGreen` → verdict palette
/// - Raw constant → only when no theme-aware path exists
abstract final class AppColors {
  /// → colorScheme.primary (light + dark)
  static const Color accentBlue = Color(0xFF1E88E5);

  /// → colorScheme.primaryContainer (light)
  static const Color accentBlueLight = Color(0xFFE3F2FD);

  /// → colorScheme.primaryContainer (dark) / inversePrimary (light)
  static const Color accentBlueDark = Color(0xFF5BA8F0);

  /// → appColors.accentBlueSoft (light)
  static const Color accentBlueSoftLight = Color(0x291E88E5);

  /// → appColors.accentBlueSoft (dark)
  static const Color accentBlueSoftDark = Color(0x381E88E5);

  /// → colorScheme.secondary (light + dark)
  static const Color verdictGreen = Color(0xFF22C55E);

  /// → colorScheme.onSecondaryContainer (light)
  static const Color verdictGreenDark = Color(0xFF15803D);

  /// → colorScheme.secondaryContainer (light)
  static const Color verdictGreenLight = Color(0xFFDCFCE7);

  /// → colorScheme.onSecondaryContainer (dark)
  static const Color verdictGreenMod = Color(0xFF4ADE80);

  /// → colorScheme.secondaryContainer (dark)
  static const Color verdictGreenSoft = Color(0x2922C55E);

  /// → colorScheme.tertiary (light + dark)
  static const Color verdictOrange = Color(0xFFF59E0B);

  /// → colorScheme.onTertiaryContainer (light)
  static const Color verdictOrangeDark = Color(0xFFB45309);

  /// Orange pill background (light) / offline banner bg.
  /// → colorScheme.tertiaryContainer (light)
  static const Color verdictOrangeLight = Color(0xFFFEF3C7);

  /// → colorScheme.onTertiaryContainer (dark)
  static const Color verdictOrangeMod = Color(0xFFFBBF24);

  /// → colorScheme.tertiaryContainer (dark)
  static const Color verdictOrangeSoft = Color(0x29F59E0B);

  /// Amber-800 — offline banner foreground text (light mode).
  static const Color offlineTextAmber = Color(0xFF92400E);

  /// Red dot — "no" criterion indicator, НЕ ПОДХОДИТ verdict dot.
  static const Color verdictRed = Color(0xFFEF4444);

  /// → colorScheme.onErrorContainer (light)
  static const Color verdictRedDark = Color(0xFFB91C1C);

  /// Red pill background (light).
  /// → colorScheme.errorContainer (light)
  static const Color verdictRedLight = Color(0xFFFEE2E2);

  /// Red text for dark pill / chip.
  static const Color verdictRedMod = Color(0xFFF87171);

  /// Translucent red @ 16% alpha — pill bg on dark surfaces.
  /// → colorScheme.errorContainer (dark)
  static const Color verdictRedSoft = Color(0x29EF4444);

  /// Reject-button label color / destructive alert.
  /// → colorScheme.error (light + dark)
  static const Color dangerRed = Color(0xFFDC2626);

  /// Reject-button border (light).
  static const Color dangerBorderLight = Color(0xFFFECACA);

  /// Reject-button border (dark).
  static const Color dangerBorderDark = Color(0xFF4C2A2A);

  /// Reject-button surface (dark).
  static const Color dangerSurfaceDark = Color(0xFF1A1416);

  /// → colorScheme.onSurface (light) / colorScheme.inverseSurface (light)
  static const Color slate900 = Color(0xFF0F172A);

  /// Strong secondary text — section headings, list labels.
  static const Color slate700 = Color(0xFF334155);

  /// Tertiary text — avatar initials, divider labels.
  static const Color slate600 = Color(0xFF475569);

  /// → colorScheme.onSurfaceVariant (light)
  static const Color slate500 = Color(0xFF64748B);

  /// Muted / hint / "rejected" status dot.
  static const Color slate400 = Color(0xFF94A3B8);

  /// → colorScheme.outline (light)
  static const Color slate300 = Color(0xFFCBD5E1);

  /// → colorScheme.outlineVariant (light)
  static const Color slate200 = Color(0xFFE2E8F0);

  /// → colorScheme.surfaceContainerHigh / Highest (light)
  static const Color slate100 = Color(0xFFF1F5F9);

  /// → colorScheme.surfaceContainerLow (light) / scaffoldBackground (light)
  static const Color iosGray = Color(0xFFF2F2F7);

  /// Avatar placeholder background (light).
  static const Color avatarBgLight = Color(0xFFEEF2F6);

  /// → colorScheme.surfaceContainerLowest / Low (dark) / scaffoldBackground (dark)
  static const Color dark900 = Color(0xFF0B0F14);

  /// Header / bottom bar / status bar surface (dark).
  static const Color dark800 = Color(0xFF11161D);

  /// → colorScheme.surface / surfaceContainer / surfaceContainerHigh (dark)
  static const Color dark700 = Color(0xFF161C24);

  /// → colorScheme.surfaceContainerHighest (dark)
  static const Color dark600 = Color(0xFF1E2630);

  /// → colorScheme.outline (dark)
  static const Color dark500 = Color(0xFF232B36);

  /// → colorScheme.outlineVariant (dark)
  static const Color dark400 = Color(0xFF2A3340);

  /// Inactive timeline dot / empty step ring (dark).
  static const Color dark300 = Color(0xFF3A4656);

  /// → colorScheme.onSurface (dark)
  static const Color darkText100 = Color(0xFFF1F5F9);

  /// → colorScheme.onSurfaceVariant (dark)
  static const Color darkText200 = Color(0xFFC2CCD8);

  /// Muted text (dark).
  static const Color darkText300 = Color(0xFF8A97A8);

  /// Label / caption (dark).
  static const Color darkText400 = Color(0xFF7C8794);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  /// 50% black — modal scrim / backdrop.
  static const Color overlay = Color(0x80000000);

  /// Card shadow (light) — black @ 4%.
  static const Color shadowSmLight = Color(0x0A000000);

  /// Panel shadow (light) — black @ 5%.
  static const Color shadowMdLight = Color(0x0D000000);

  /// Sheet shadow (light) — black @ 7%.
  static const Color shadowLgLight = Color(0x12000000);

  /// Card shadow (dark) — black @ 20%.
  static const Color shadowSmDark = Color(0x33000000);

  /// Panel shadow (dark) — black @ 28%.
  static const Color shadowMdDark = Color(0x47000000);

  /// Sheet shadow (dark) — black @ 40%.
  static const Color shadowLgDark = Color(0x66000000);
}
