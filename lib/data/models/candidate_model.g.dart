// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CandidateModel _$CandidateModelFromJson(Map<String, dynamic> json) =>
    CandidateModel(
      id: json['id'] as String,
      name: json['name'] as String,
      position: json['position'] as String,
      posLabel: json['pos_label'] as String,
      file: json['file'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      city: json['city'] as String,
      tg: json['tg'] as String,
      exp: _expFromJson(json['exp'] as List),
      totalExp: json['total_exp'] as String,
      stack: json['stack'] as String,
      edu: json['edu'] as String,
      verdict: json['verdict'] as String,
      vc: json['vc'] as String,
      criteria: _expFromJson(json['criteria'] as List),
      summary: json['summary'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      status: json['status'] as String? ?? 'new',
      dateAdded: json['date_added'] as String?,
    );

Map<String, dynamic> _$CandidateModelToJson(CandidateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'position': instance.position,
      'pos_label': instance.posLabel,
      'file': instance.file,
      'email': instance.email,
      'phone': instance.phone,
      'city': instance.city,
      'tg': instance.tg,
      'exp': _expToJson(instance.exp),
      'total_exp': instance.totalExp,
      'stack': instance.stack,
      'edu': instance.edu,
      'verdict': instance.verdict,
      'vc': instance.vc,
      'criteria': _expToJson(instance.criteria),
      'summary': instance.summary,
      'questions': instance.questions,
      'status': instance.status,
      'date_added': instance.dateAdded,
    };
