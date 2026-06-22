import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../network/mock_interceptor.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio(BaseOptions(baseUrl: 'https://mock.api/'))
    ..interceptors.add(MockInterceptor());

  @Named('candidates_box')
  @lazySingleton
  Box<String> candidatesBox() => Hive.box<String>('candidates');

  @Named('statuses_box')
  @lazySingleton
  Box<String> statusesBox() => Hive.box<String>('statuses');
}
