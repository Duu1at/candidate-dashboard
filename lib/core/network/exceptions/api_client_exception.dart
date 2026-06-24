
import 'package:candidate_dashboard/core/core.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

@immutable
final class ApiClientException extends AppException<DioException> {
  const ApiClientException(
    super.error, {
    this.code,
    super.message,
    super.stackTrace,
    super.type,
    super.handleType,
  });

  final int? code;

  @override
  ErrorModel getModel() {
    return ErrorModel(
      title: "Что-то пошло не так",
      message: error.errorMessage ?? "Техническая ошибка, пожалуйста, обратитесь в нашу службу поддержки",
      icon: const Icon(Icons.error),
    );
  }

  @override
  String getUiMessage() {
    return error.errorMessage ?? "Что-то пошло не так";
  }
}

@immutable
final class ApiClientUnknownException extends AppException<Object> {
  const ApiClientUnknownException(
    super.error, {
    super.stackTrace,
    super.message,
  });

  @override
  ErrorModel getModel() {
    return ErrorModel(
      title: "Что-то пошло не так",
      message: message ?? "Техническая ошибка, пожалуйста, обратитесь в нашу службу поддержки",
      icon: const Icon(Icons.error),
    );
  }

  @override
  String getUiMessage() {
    return message ?? "Что-то пошло не так";
  }
}
