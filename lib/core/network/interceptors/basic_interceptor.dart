import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:candidate_dashboard/core/core.dart';

class BasicInterceptor extends QueuedInterceptor {
  BasicInterceptor({
    required this.userName,
    required this.passWord,
  });

  final ResolveValue userName;
  final ResolveValue passWord;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final userNameValue = userName.call() ?? 'user';
    final passWordValue = passWord.call() ?? 'user';
    options.headers.addAll({
      'Authorization': 'Basic ${base64Encode(utf8.encode('$userNameValue:$passWordValue'))}',
    });
    return handler.next(options);
  }
}
