import 'package:dio/dio.dart';
import 'package:candidate_dashboard/core/core.dart';

//
class BaseInterceptor extends Interceptor {
  const BaseInterceptor({
    this.language,
    this.buildNumber,
    this.version,
    this.platform,
  });

  final ResolveValue? language;
  final ResolveValue? buildNumber;
  final ResolveValue? version;
  final ResolveValue? platform;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final languageValue = language?.call();
    final buildNumberValue = buildNumber?.call();
    final platformValue = platform?.call();
    final versionValue = version?.call();
    options.headers.addAll({
      if (languageValue != null && languageValue.isNotEmpty)
        'Accept-Language': languageValue,
      if (buildNumberValue != null && buildNumberValue.isNotEmpty)
        'X-App-Version-Build-Number': buildNumberValue,
      if (platformValue != null && platformValue.isNotEmpty)
        'X-App-Platform': platformValue,
      if (versionValue != null && versionValue.isNotEmpty)
        'X-App-Version': versionValue,
    });
    return handler.next(options);
  }
}
