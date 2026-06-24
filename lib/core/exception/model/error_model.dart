import 'package:flutter/material.dart';

@immutable
final class ErrorModel {
  const ErrorModel({
    required this.title,
    required this.message,
    this.icon,
  });

  final Widget? icon;
  final String title;
  final String message;
}
