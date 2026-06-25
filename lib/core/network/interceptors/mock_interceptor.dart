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

    final uriPath = options.uri.path;

    if (options.method == 'GET' && uriPath.endsWith('/candidates')) {
      return _handleList(options, handler);
    }
    if (options.method == 'GET' &&
        uriPath.contains('/candidates/') &&
        !uriPath.endsWith('/status')) {
      return _handleGetById(options, handler);
    }
    if (options.method == 'PATCH' && uriPath.endsWith('/status')) {
      return _handlePatch(options, handler);
    }

    return handler.next(options);
  }

  Future<void> _handleList(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final all = await _loadAll();
    final params = options.queryParameters;

    final search = (params['search'] as String? ?? '').toLowerCase();
    final filter = params['filter'] as String?;
    final sort = params['sort'] as String? ?? 'date_added';
    final page = int.tryParse(params['page']?.toString() ?? '1') ?? 1;
    final limit = int.tryParse(params['limit']?.toString() ?? '10') ?? 10;

    var result = all.where((c) {
      final matchSearch =
          search.isEmpty ||
          (c['name'] as String? ?? '').toLowerCase().contains(search);
      final matchFilter = filter == null || c['vc'] == filter;
      return matchSearch && matchFilter;
    }).toList();

    switch (sort) {
      case 'name':
        result.sort(
          (a, b) => (a['name'] as String? ?? '')
              .compareTo(b['name'] as String? ?? ''),
        );
      case 'experience':
        result.sort(
          (a, b) =>
              _parseExp(b['total_exp']).compareTo(_parseExp(a['total_exp'])),
        );
      case 'date_added':
      default:
        result.sort(
          (a, b) => (b['date_added'] as String? ?? '')
              .compareTo(a['date_added'] as String? ?? ''),
        );
    }

    final total = result.length;
    final start = (page - 1) * limit;
    final items = result.skip(start).take(limit).toList();

    return handler.resolve(
      Response(
        requestOptions: options,
        statusCode: 200,
        data: {'items': items, 'total': total, 'page': page, 'limit': limit},
      ),
    );
  }

  Future<void> _handleGetById(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final decodedPath = Uri.decodeFull(options.uri.path);
    final idMatch = RegExp(r'/candidates/([^/]+)').firstMatch(decodedPath);
    final id = idMatch?.group(1);

    final all = await _loadAll();
    Map<String, dynamic>? candidate;
    for (final c in all) {
      if (c['id'] == id) {
        candidate = c;
        break;
      }
    }

    if (candidate == null) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: options, statusCode: 404),
        ),
      );
    }

    return handler.resolve(
      Response(requestOptions: options, statusCode: 200, data: candidate),
    );
  }

  Future<void> _handlePatch(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_random.nextDouble() < 0.1) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response(requestOptions: options, statusCode: 500),
        ),
      );
    }
    return handler.resolve(
      Response(requestOptions: options, statusCode: 200, data: null),
    );
  }

  Future<List<Map<String, dynamic>>> _loadAll() async {
    final json = await rootBundle.loadString('mock/candidates-large.json');
    final list = jsonDecode(json) as List<dynamic>;
    return list.cast<Map<String, dynamic>>();
  }

  double _parseExp(dynamic val) {
    if (val == null) return 0.0;
    final match = RegExp(r'[\d.]+').firstMatch(val.toString());
    return match != null ? double.tryParse(match.group(0)!) ?? 0.0 : 0.0;
  }
}
