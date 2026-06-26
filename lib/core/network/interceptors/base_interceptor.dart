import 'package:dio/dio.dart';

class BaseInterceptor extends Interceptor {
  const BaseInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({});
    return handler.next(options);
  }
}
