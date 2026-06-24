
import 'package:candidate_dashboard/core/core.dart';
import 'package:flutter/material.dart';

@immutable
final class ConnectionException extends AppException<Object> {
  const ConnectionException(
    super.error, {
    super.handleType = ExceptionHandleType.dialog,
    super.stackTrace,
    super.message,
    super.type,
  });

  @override
  ErrorModel getModel() {
    return const ErrorModel(
      title: "Нет подключения к интернету",
      message: "Нет подключения к интернету",
      icon: Icon(Icons.wifi_off),
    );
  }

  @override
  String getUiMessage() {
    return "Нет подключения к интернету";
  }
}
