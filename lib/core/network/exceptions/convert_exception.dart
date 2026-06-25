
import 'package:candidate_dashboard/core/core.dart';
import 'package:flutter/material.dart';

@immutable
final class ConvertException extends AppException<Object> {
  const ConvertException(
    super.error, {
    super.stackTrace,
    super.message,
    super.type,
    super.handleType,
  });

  @override
  ErrorModel getModel() {
    return const ErrorModel(
      title: "Что-то пошло не так",
      message: "Разработчики уже работают над исправлением ошибки, пожалуйста, обратитесь в нашу службу поддержки",
      icon: Icon(Icons.warning),
    );
  }

  @override
  String getUiMessage() {
    return "Разработчики уже работают над исправлением ошибки, пожалуйста, обратитесь в нашу службу поддержки";
  }
}
