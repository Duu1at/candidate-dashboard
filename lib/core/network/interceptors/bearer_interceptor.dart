
import 'package:candidate_dashboard/core/core.dart';
import 'package:dio/dio.dart';

class BearerInterceptor extends QueuedInterceptor {
  BearerInterceptor({
    required this.getAccessToken,
    required this.getRefreshToken,
  });

  final ResolveValue getAccessToken;
  final ResolveValue getRefreshToken;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final accessToken = getAccessToken.call();
    options.headers.addAll({
      if (accessToken != null && accessToken.trim().isNotEmpty) 'Authorization': 'Bearer $accessToken',
    });
    return handler.next(options);
  }
}
