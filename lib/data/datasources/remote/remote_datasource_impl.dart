import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:candidate_dashboard/data/data.dart';

@LazySingleton(as: RemoteDatasource)
final class RemoteDatasourceImpl implements RemoteDatasource {
const  RemoteDatasourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<Candidate>> getCandidates() async {
    final response = await _dio.get<String>('/candidates');
    final data = jsonDecode(response.data!) as List<dynamic>;
    return data
        .map((e) => Candidate.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> updateStatus(String id, String status) async {
    await _dio.patch<void>('/candidates/$id/status', data: {'status': status});
  }
}
