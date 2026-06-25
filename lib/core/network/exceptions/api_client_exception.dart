import 'package:dio/dio.dart';

final class ApiClientException implements Exception {
  const ApiClientException(this.error, {this.code, this.stackTrace});

  final DioException error;
  final int? code;
  final StackTrace? stackTrace;
}

final class ApiClientUnknownException implements Exception {
  const ApiClientUnknownException(this.cause, {this.stackTrace});

  final Object cause;
  final StackTrace? stackTrace;
}
