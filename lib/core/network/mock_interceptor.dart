import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class MockInterceptor extends Interceptor {
  final _random = Random();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final delay = 300 + _random.nextInt(500);
    await Future<void>.delayed(Duration(milliseconds: delay));

    if (options.method == 'GET' && options.path.contains('/candidates')) {
      final jsonStr = await rootBundle.loadString('mock/candidates.json');
      handler.resolve(
        Response(
          requestOptions: options,
          data: jsonStr,
          statusCode: 200,
        ),
      );
      return;
    }

    if (options.method == 'PATCH' && options.path.contains('/status')) {
      // ~10% random error
      if (_random.nextDouble() < 0.1) {
        handler.reject(
          DioException(
            requestOptions: options,
            message: 'Ошибка сервера. Попробуйте ещё раз.',
            type: DioExceptionType.badResponse,
          ),
        );
        return;
      }
      handler.resolve(
        Response(requestOptions: options, statusCode: 200),
      );
      return;
    }

    handler.next(options);
  }
}
