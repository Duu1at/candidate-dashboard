import 'package:candidate_dashboard/core/core.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  MockInterceptor get mockInterceptor => MockInterceptor();

  @lazySingleton
  ConnectionService get connectionService =>
      ConnectivityBasedConnectionChecker();

  @lazySingleton
  Dio dio(MockInterceptor mockInterceptor) {
    return Dio(
        BaseOptions(
          baseUrl: 'https://mock.api/',
          contentType: 'application/json; charset=utf-8',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      )
      ..interceptors.addAll([
        const BaseInterceptor(),
        mockInterceptor,
      ]);
  }

  @lazySingleton
  ApiClient apiClient(
    Dio dio,
    ConnectionService connection,
  ) {
    return ApiClient.fromDio(
      dio: dio,
      connection: connection,
    );
  }

  @Named('candidates_box')
  @lazySingleton
  Box<String> candidatesBox() => Hive.box<String>('candidates');

  @Named('statuses_box')
  @lazySingleton
  Box<String> statusesBox() => Hive.box<String>('statuses');
}
