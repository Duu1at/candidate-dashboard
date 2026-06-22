import 'package:flutter/material.dart';
import '../theme/theme.dart';

Color verdictColor(BuildContext context, String vc) => switch (vc) {
      'verdict-green' => Theme.of(context).extension<AppColorsExt>()!.success,
      'verdict-orange' => Theme.of(context).extension<AppColorsExt>()!.warning,
      'verdict-red' => Theme.of(context).colorScheme.error,
      _ => Theme.of(context).colorScheme.outline,
    };

Color verdictContainerColor(BuildContext context, String vc) => switch (vc) {
      'verdict-green' =>
        Theme.of(context).extension<AppColorsExt>()!.successContainer,
      'verdict-orange' =>
        Theme.of(context).extension<AppColorsExt>()!.warningContainer,
      'verdict-red' => Theme.of(context).colorScheme.errorContainer,
      _ => Theme.of(context).colorScheme.surfaceContainerHighest,
    };

Color onVerdictContainerColor(BuildContext context, String vc) => switch (vc) {
      'verdict-green' =>
        Theme.of(context).extension<AppColorsExt>()!.onSuccessContainer,
      'verdict-orange' =>
        Theme.of(context).extension<AppColorsExt>()!.onWarning,
      'verdict-red' => Theme.of(context).colorScheme.onErrorContainer,
      _ => Theme.of(context).colorScheme.onSurface,
    };

Color criteriaColor(BuildContext context, String status) => switch (status) {
      'ok' => Theme.of(context).extension<AppColorsExt>()!.success,
      'warn' => Theme.of(context).extension<AppColorsExt>()!.warning,
      _ => Theme.of(context).colorScheme.error,
    };

IconData criteriaIcon(String status) => switch (status) {
      'ok' => Icons.check_circle_outline_rounded,
      'warn' => Icons.warning_amber_rounded,
      _ => Icons.cancel_outlined,
    };
