// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidates_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandidatesPage _$CandidatesPageFromJson(Map<String, dynamic> json) =>
    CandidatesPage(
      items: (json['items'] as List<dynamic>)
          .map((e) => CandidateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$CandidatesPageToJson(CandidatesPage instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
    };
