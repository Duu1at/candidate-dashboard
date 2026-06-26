import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

AppColorsExt _ext(BuildContext context) {
  return Theme.of(context).extension<AppColorsExt>()!;
}

VerdictPalette verdictPalette(BuildContext context, String vc) {
  return switch (vc) {
    'verdict-green' => _ext(context).verdictGreen,
    'verdict-orange' => _ext(context).verdictOrange,
    _ => _ext(context).verdictRed,
  };
}

Color verdictColor(BuildContext context, String vc) {
  return verdictPalette(context, vc).dot;
}

Color verdictContainerColor(BuildContext context, String vc) {
  return verdictPalette(context, vc).background;
}

Color onVerdictContainerColor(BuildContext context, String vc) {
  return verdictPalette(context, vc).foreground;
}

VerdictPalette criteriaPalette(BuildContext context, String status) {
  return switch (status) {
    'ok' => _ext(context).verdictGreen,
    'warn' => _ext(context).verdictOrange,
    _ => _ext(context).verdictRed,
  };
}

Color criteriaColor(BuildContext context, String status) {
  return criteriaPalette(context, status).dot;
}

IconData criteriaIcon(String status) {
  return switch (status) {
    'ok' => Icons.check_circle_outline_rounded,
    'warn' => Icons.warning_amber_rounded,
    _ => Icons.cancel_outlined,
  };
}
