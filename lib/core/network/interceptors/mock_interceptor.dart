import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class MockInterceptor extends Interceptor {
  static final _random = Random();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final delay = 300 + _random.nextInt(501);
    await Future<void>.delayed(Duration(milliseconds: delay));

    if (options.method == 'GET' && options.path.contains('/candidates')) {
      final jsonString = await rootBundle.loadString('mock/candidates.json');
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: jsonDecode(jsonString),
        ),
      );
    }

    if (options.method == 'PATCH' && options.path.contains('/status')) {
      if (_random.nextDouble() < 0.1) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.badResponse,
            response: Response(
              requestOptions: options,
              statusCode: 500,
            ),
          ),
        );
      }
      return handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: null,
        ),
      );
    }

    return handler.next(options);
  }
}
