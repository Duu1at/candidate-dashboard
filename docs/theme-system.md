# Theme System

> Canonical reference for colors, typography, spacing, radii, shadows, and
> component themes in Candidate Dashboard.
>
> **Audience:** developers and AI agents writing UI code. Read this before
> adding any new screen or widget so the result adapts correctly to light /
> dark mode and matches the design system.
>
> **Looking for pre-built widgets?** See [ui-components.md](ui-components.md)
> first — text fields, banners, submit buttons, spinners, etc. already exist
> and use the tokens documented here. This file covers the tokens; that file
> covers the widgets that consume them.

---

## Folder layout

```
lib/core/theme/
├── app_theme.dart                       ← AppTheme.light / AppTheme.dark assembly
├── theme.dart                           ← public barrel
├── colors/
│   ├── app_colors.dart                  ← AppColors  (raw constants, single source of truth)
│   ├── app_colors_extension.dart        ← AppColorsExt + VerdictPalette (theme-aware non-Material colors + shadows)
│   └── color_schemes.dart              ← AppColorSchemes.light / .dark
├── components/                          ← one builder per Material widget theme
│   ├── app_bar_component_theme.dart
│   ├── bottom_sheet_component_theme.dart
│   ├── button_component_theme.dart
│   ├── card_component_theme.dart
│   ├── chip_component_theme.dart
│   ├── dialog_component_theme.dart
│   ├── divider_component_theme.dart
│   ├── floating_action_button_theme.dart
│   ├── input_component_theme.dart
│   ├── list_tile_component_theme.dart
│   ├── navigation_bar_component_theme.dart
│   ├── popup_menu_component_theme.dart
│   ├── progress_indicator_component_theme.dart
│   ├── snackbar_component_theme.dart
│   ├── switch_component_theme.dart
│   └── tooltip_component_theme.dart
├── extension/
│   └── context_extensions.dart          ← context.colors / textTheme / appColors / appTextStyles / appTheme
├── foundations/
│   ├── app_spacing.dart                 ← AppSpacing.x1 … x16, AppSpacing.bottom(context)
│   ├── app_radius.dart                  ← AppRadius.button / .card / .modal / .chip / …
│   ├── app_shadow.dart                  ← AppShadow.{sm,md,lg}{Light,Dark}
│   └── app_opacity.dart                 ← AppOpacity.tint / .disabledForeground / .disabledBackground / .brandGlow
└── typography/
    ├── app_text_theme.dart              ← AppTextTheme.from(color) — every Material role + amountSmall
    └── app_text_theme_extension.dart    ← AppTextThemeExt: error / disabled / muted / onPrimary / link
```

Everything is re-exported from `lib/core/theme/theme.dart` —
features import via `package:candidate_dashboard/core/core.dart` and never reach into subfolders directly.

---

## The five `BuildContext` shortcuts

```dart
context.colors          // ColorScheme           (Material 3 tokens)
context.textTheme       // TextTheme             (Material 3 text roles)
context.appColors       // AppColorsExt          (verdict palettes / offline banner / accentBlueSoft / shadows)
context.appTextStyles   // AppTextThemeExt       (error / disabled / muted / onPrimary / link variants)
context.appTheme        // ThemeData             (escape hatch, rarely needed)
```

Always prefer these over `Theme.of(context).colorScheme` / `.textTheme` —
they're the same thing with less noise.

---

## Picking the right color token

Walk the list top to bottom and stop at the first match.

1. **Is it a Material 3 role?** (primary, secondary, surface, onSurface,
   error, outline, etc.) → `context.colors.X`.

2. **Is it a verdict / status / offline / soft overlay / shadow?**
   → `context.appColors.X` (see table below).

3. **Is it a tinted overlay built from another token?**
   → `someColor.withValues(alpha: AppOpacity.tint)` is fine — it adapts because
   the source color is theme-aware.

4. **Is it a third-party brand color** (WhatsApp green, Telegram blue)
   that should look the same in light and dark?
   → Hardcode it as a `const Color` _near the widget_ and add a comment
   explaining why it doesn't go through the theme.

5. **Anything else** → reach for `AppColors.X` only as a last resort, and
   only if the constant is truly mode-independent (e.g. `AppColors.transparent`,
   `AppColors.black`). If you're tempted to use a raw `AppColors` constant in a
   widget, you almost always want a theme token instead.

❌ **Never inline a hex literal** (`Color(0xFF1E88E5)`) in a widget.

❌ **Never use `Colors.X`** from `flutter/material.dart` directly — pick a
theme token instead.

---

## `AppColorsExt` fields reference

| Field | Type | Light | Dark |
| --- | --- | --- | --- |
| `verdictGreen` | `VerdictPalette` | bg `#DCFCE7`, fg `#15803D`, dot `#22C55E` | bg `#22C55E29`, fg `#4ADE80`, dot `#22C55E` |
| `verdictOrange` | `VerdictPalette` | bg `#FEF3C7`, fg `#B45309`, dot `#F59E0B` | bg `#F59E0B29`, fg `#FBBF24`, dot `#F59E0B` |
| `verdictRed` | `VerdictPalette` | bg `#FEE2E2`, fg `#B91C1C`, dot `#EF4444` | bg `#EF444429`, fg `#F87171`, dot `#EF4444` |
| `statusRejected` | `Color` | `#94A3B8` (slate400) | `#94A3B8` (slate400) |
| `offlineBannerBg` | `Color` | `#FEF3C7` | `#F59E0B29` |
| `offlineBannerText` | `Color` | `#92400E` | `#FBBF24` |
| `accentBlueSoft` | `Color` | `#1E88E529` | `#1E88E538` |
| `shadowSm` | `List<BoxShadow>` | black 4% blur 2 | black 20% blur 2 |
| `shadowMd` | `List<BoxShadow>` | black 5% blur 12 | black 28% blur 12 |
| `shadowLg` | `List<BoxShadow>` | black 7% blur 24 | black 40% blur 24 |

### VerdictPalette fields

```dart
context.appColors.verdictGreen.background  // pill / chip background
context.appColors.verdictGreen.foreground  // pill / chip text color
context.appColors.verdictGreen.dot         // status dot color
```

The same pattern applies to `verdictOrange` and `verdictRed`.

---

## Picking the right text style

```dart
context.textTheme.displayLarge     // 48 / 56 · w700  (large hero number, tabular)
context.textTheme.displayMedium    // 40 / 48 · w700  (tabular)
context.textTheme.displaySmall     // 32 / 40 · w700  (large amount, tabular)
context.textTheme.headlineLarge    // 27 / 33 · w700  (screen title)
context.textTheme.headlineMedium   // 20 / 26 · w700  (section heading)
context.textTheme.headlineSmall    // 18 / 24 · w600  (card heading)
context.textTheme.titleLarge       // 16 / 22 · w600  (AppBar title)
context.textTheme.titleMedium      // 16 / 22 · w600
context.textTheme.titleSmall       // 14 / 20 · w600
context.textTheme.bodyLarge        // 15 / 22 · w600  (emphasized body)
context.textTheme.bodyMedium       // 14 / 22 · w400  (default body)
context.textTheme.bodySmall        // 13 / 18 · w500  (caption / helper)
context.textTheme.labelLarge       // 15 / 20 · w600  (button label)
context.textTheme.labelMedium      // 13 / 18 · w600  (chip label)
context.textTheme.labelSmall       // 12 / 16 · w500  (badge, tiny label)
```

`AppTextTheme` also defines `amountSmall` (24 / 32 · w700, tabular) for
monetary or numeric displays — access it via `AppTextTheme.from(color).amountSmall`
when you need it outside the normal Material roles.

Hover any field on `AppTextTheme` to see size / weight in your IDE.

For variants (error / disabled / muted / onPrimary), reach for
`context.appTextStyles`:

```dart
context.appTextStyles.error.bodySmall    // bodySmall in colorScheme.error
context.appTextStyles.disabled.bodyLarge // bodyLarge in onSurface @ 38%
context.appTextStyles.muted.bodyMedium   // bodyMedium in onSurfaceVariant
context.appTextStyles.onPrimary.titleLarge
context.appTextStyles.link               // single underlined primary bodyMedium
```

❌ **Don't write `style.copyWith(color: colors.error)` zigzags** —
use `context.appTextStyles.error.X` instead.

---

## Spacing, radius, shadow, opacity

### Spacing — `AppSpacing`

| Constant | Value |
| -------- | ----- |
| `x1` | 4 |
| `x2` | 8 |
| `x3` | 12 |
| `x4` | 16 |
| `x5` | 20 |
| `x6` | 24 |
| `x7` | 28 |
| `x8` | 32 |
| `x10` | 40 |
| `x12` | 48 |
| `x14` | 56 |
| `x16` | 64 |
| `bottom(context)` | `viewPadding.bottom + 16` |

> Note: x9, x11, x13, x15 are not defined — jump to the next available step.

### Radius — `AppRadius`

| Constant | Value | Use |
| -------- | ----- | --- |
| `checkbox` / `checkboxBorderRadius` | 6 | Checkbox / toggle |
| `tag` / `tagBorderRadius` | 8 | Stack tag chip |
| `button` / `buttonBorderRadius` | 12 | Standard button |
| `input` / `inputBorderRadius` | 12 | Input field |
| `cta` / `ctaBorderRadius` | 13 | Primary CTA button |
| `contactCard` / `contactCardBorderRadius` | 14 | Contact action button |
| `card` / `cardBorderRadius` | 16 | Card / list item |
| `modal` / `modalBorderRadius` | 20 | Bottom sheet (top corners only) |
| `chip` / `chipBorderRadius` | 999 | Pill badges / status chips |

Each constant has both a `double` form and a pre-built `BorderRadius` form.
Prefer the `BorderRadius` form in `BoxDecoration` to avoid `BorderRadius.circular(...)` calls.

### Shadow

```dart
context.appColors.shadowSm   // theme-aware small shadow (recommended)
context.appColors.shadowMd   // theme-aware medium shadow (recommended)
context.appColors.shadowLg   // theme-aware large shadow (recommended)

AppShadow.mdLight / AppShadow.mdDark  // direct constants (special cases only)
```

### Opacity — `AppOpacity`

| Constant | Value | Use |
| -------- | ----- | --- |
| `tint` | 0.12 | Tinted background overlays |
| `disabledForeground` | 0.38 | Disabled text / icon alpha |
| `disabledBackground` | 0.12 | Disabled container alpha |
| `brandGlow` | 0.27 | Brand glow / soft highlight |

❌ **No magic numbers.** `EdgeInsets.all(13)` is wrong; use a token.

---

## Worked examples

### Default body text (adapts automatically)

```dart
Text('Hello', style: context.textTheme.bodyMedium)
```

### Error message under a form field

```dart
Text(errorText, style: context.appTextStyles.error.bodySmall)
```

### Verdict badge (green / orange / red)

```dart
DecoratedBox(
  decoration: BoxDecoration(
    color: context.appColors.verdictGreen.background,
    borderRadius: AppRadius.chipBorderRadius,
  ),
  child: Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.x3,
      vertical: AppSpacing.x1,
    ),
    child: Text(
      label,
      style: context.textTheme.labelMedium?.copyWith(
        color: context.appColors.verdictGreen.foreground,
      ),
    ),
  ),
)
```

Swap `verdictGreen` for `verdictOrange` or `verdictRed` to get the other verdict states.

### Card with elevation in both modes

```dart
DecoratedBox(
  decoration: BoxDecoration(
    color: context.colors.surface,
    borderRadius: AppRadius.cardBorderRadius,
    boxShadow: context.appColors.shadowMd,
  ),
  child: …,
)
```

### Filled button (no styling needed — theme handles it)

```dart
FilledButton(onPressed: …, child: Text('Save'))
```

The button gets its `backgroundColor`, `foregroundColor`, padding, radius
and text style from `ButtonComponentTheme.filled(...)`. **Don't override
them** unless you have a strong reason — instead extend the theme.

---

## Extending the theme

### Add a new color

1. Add the raw constant to [colors/app_colors.dart](../lib/core/theme/colors/app_colors.dart) with a doc comment showing where it lands (`→ colorScheme.X` or `→ appColors.X`).
2. **If it's a Material 3 role** (primary, secondary, surface, …): wire it into [colors/color_schemes.dart](../lib/core/theme/colors/color_schemes.dart) for both `light` and `dark`.
3. **If it falls outside Material 3** (verdict palette, offline banner, soft overlay): add a field to `AppColorsExt` in [colors/app_colors_extension.dart](../lib/core/theme/colors/app_colors_extension.dart) and supply both `light` and `dark` values. The doc comment must list `- light:` and `- dark:` hex resolutions.

If the new color is a three-part verdict-style palette (background + foreground + dot),
use `VerdictPalette` instead of a plain `Color`.

### Add a new text style

If it maps to a Material role, modify the value in
[typography/app_text_theme.dart](../lib/core/theme/typography/app_text_theme.dart) `from(color)` factory.

If it's a variant on top of an existing role (e.g. "warning text"), add a
field to `AppTextThemeExt` in
[typography/app_text_theme_extension.dart](../lib/core/theme/typography/app_text_theme_extension.dart).

### Theme a new Material widget

1. Create `components/<name>_component_theme.dart` exporting an
   `abstract final class XComponentTheme` with a `static build(...)`
   method that takes `ColorScheme` (and `TextTheme` / `AppColorsExt`
   when needed) and returns the theme data.
2. Wire it in [app_theme.dart](../lib/core/theme/app_theme.dart) inside `_build({...})`.
3. Export from `theme.dart` barrel.

The component theme **never branches on `Brightness`** unless its structure
genuinely differs between modes — colors are always sourced from the
`ColorScheme` argument so the same builder works for both themes.

---

## Anti-patterns to reject in code review

| Anti-pattern | Replacement |
| --- | --- |
| `Color(0xFF1E88E5)` inline | `context.colors.primary` |
| `Colors.red`, `Colors.grey[300]` | `context.colors.error`, `context.colors.outline` |
| `AppColors.dangerRed` in a widget | `context.colors.error` |
| `AppColors.verdictGreen` in a widget | `context.appColors.verdictGreen.dot` |
| `Theme.of(context).colorScheme` | `context.colors` |
| `Theme.of(context).textTheme` | `context.textTheme` |
| `style.copyWith(color: colors.error)` for error text | `context.appTextStyles.error.X` |
| `EdgeInsets.all(16)` magic number | `EdgeInsets.all(AppSpacing.x4)` |
| `BorderRadius.circular(12)` magic number | `AppRadius.buttonBorderRadius` |
| Hardcoded `BoxShadow(color: Colors.black12, …)` | `context.appColors.shadowMd` |
| `_buildXyz()` private widget method | Extract a `StatelessWidget` class |

---

## Quick lookup

When the designer hands you a hex value, search [colors/app_colors.dart](../lib/core/theme/colors/app_colors.dart). Every constant carries a doc comment that tells you the _theme-level_ token to use (not the constant itself). Use the token, not the raw color.
