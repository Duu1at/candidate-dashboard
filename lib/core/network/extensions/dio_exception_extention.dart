import 'package:dio/dio.dart';

extension DioExceptionX on DioException {
 //  add more error codes if needed
  String? get errorMessage {
    final data = response?.data;
    if (data is Map) return data['message'] as String?;
    return null;
  }

  int? get errorCode {
    final data = response?.data;
    if (data is Map) return data['code'] as int?;
    return null;
  }

}
