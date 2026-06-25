import 'package:candidate_dashboard/core/core.dart';
import 'package:flutter/material.dart';

abstract class ErrorHandler {
  const ErrorHandler();

  void handleError(Object error, BuildContext context);

  void handleAuthError(Object error, BuildContext context);

  String parseErrorMessage(Object error) {
    return error is String
        ? error
        : error is AppException
        ? error.getUiMessage()
        : "Техническая ошибка, пожалуйста, обратитесь в нашу службу поддержки";
  }

  ErrorModel parseErrorModel(Object error) {
    return error is String
        ? ErrorModel(
            title: "Что-то пошло не так",
            message: error,
            icon: const Icon(Icons.error),
          )
        : error is AppException
        ? error.getModel()
        : const ErrorModel(
            title: "Что-то пошло не так",
            message:
                "Техническая ошибка, пожалуйста, обратитесь в нашу службу поддержки",
            icon: Icon(Icons.error),
          );
  }
}
