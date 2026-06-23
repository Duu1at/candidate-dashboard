import 'package:flutter/material.dart';
import '../theme/theme.dart';

AppColorsExt _ext(BuildContext context) =>
    Theme.of(context).extension<AppColorsExt>()!;

VerdictPalette verdictPalette(BuildContext context, String vc) => switch (vc) {
  'verdict-green' => _ext(context).verdictGreen,
  'verdict-orange' => _ext(context).verdictOrange,
  _ => _ext(context).verdictRed,
};

Color verdictColor(BuildContext context, String vc) =>
    verdictPalette(context, vc).dot;

Color verdictContainerColor(BuildContext context, String vc) =>
    verdictPalette(context, vc).background;

Color onVerdictContainerColor(BuildContext context, String vc) =>
    verdictPalette(context, vc).foreground;

VerdictPalette criteriaPalette(BuildContext context, String status) =>
    switch (status) {
      'ok' => _ext(context).verdictGreen,
      'warn' => _ext(context).verdictOrange,
      _ => _ext(context).verdictRed,
    };

Color criteriaColor(BuildContext context, String status) =>
    criteriaPalette(context, status).dot;

IconData criteriaIcon(String status) => switch (status) {
  'ok' => Icons.check_circle_outline_rounded,
  'warn' => Icons.warning_amber_rounded,
  _ => Icons.cancel_outlined,
};
