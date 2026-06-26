import 'package:flutter/material.dart';

IconData criteriaIcon(String status) {
  return switch (status) {
    'ok' => Icons.check_circle_outline_rounded,
    'warn' => Icons.warning_amber_rounded,
    _ => Icons.cancel_outlined,
  };
}
