import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'candidate_model.g.dart';

List<List<String>> _expFromJson(List<dynamic> json) =>
    json.map((e) => List<String>.from(e as List)).toList();

List<dynamic> _expToJson(List<List<String>> list) => list;

@JsonSerializable()
@immutable
final class CandidateModel extends Equatable {
  const CandidateModel({
    required this.id,
    required this.name,
    required this.position,
    required this.posLabel,
    required this.file,
    required this.email,
    required this.phone,
    required this.city,
    required this.tg,
    required this.exp,
    required this.totalExp,
    required this.stack,
    required this.edu,
    required this.verdict,
    required this.vc,
    required this.criteria,
    required this.summary,
    required this.questions,
    this.status = 'new',
    this.dateAdded,
  });

  final String id;
  final String name;
  final String position;
  @JsonKey(name: 'pos_label')
  final String posLabel;
  final String file;
  final String email;
  final String phone;
  final String city;
  final String tg;
  @JsonKey(fromJson: _expFromJson, toJson: _expToJson)
  final List<List<String>> exp;
  @JsonKey(name: 'total_exp')
  final String totalExp;
  final String stack;
  final String edu;
  final String verdict;
  final String vc;
  @JsonKey(fromJson: _expFromJson, toJson: _expToJson)
  final List<List<String>> criteria;
  final String summary;
  final List<String> questions;
  final String status;
  @JsonKey(name: 'date_added')
  final String? dateAdded;

  factory CandidateModel.fromJson(Map<String, dynamic> json) {
    return _$CandidateModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CandidateModelToJson(this);
  }

  CandidateModel copyWith({
    String? id,
    String? name,
    String? position,
    String? posLabel,
    String? file,
    String? email,
    String? phone,
    String? city,
    String? tg,
    List<List<String>>? exp,
    String? totalExp,
    String? stack,
    String? edu,
    String? verdict,
    String? vc,
    List<List<String>>? criteria,
    String? summary,
    List<String>? questions,
    String? status,
    String? dateAdded,
  }) {
    return CandidateModel(
      id: id ?? this.id,
      name: name ?? this.name,
      position: position ?? this.position,
      posLabel: posLabel ?? this.posLabel,
      file: file ?? this.file,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      tg: tg ?? this.tg,
      exp: exp ?? this.exp,
      totalExp: totalExp ?? this.totalExp,
      stack: stack ?? this.stack,
      edu: edu ?? this.edu,
      verdict: verdict ?? this.verdict,
      vc: vc ?? this.vc,
      criteria: criteria ?? this.criteria,
      summary: summary ?? this.summary,
      questions: questions ?? this.questions,
      status: status ?? this.status,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }

  String get initials {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  List<String> get stackTags {
    return stack
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
  }

  String get eduInstitution {
    final i = edu.indexOf(',');
    return i > 0 ? edu.substring(0, i).trim() : edu;
  }

  String get eduDetails {
    final i = edu.indexOf(',');
    return i > 0 ? edu.substring(i + 1).trim() : '';
  }

  @override
  List<Object?> get props => [
    id,
    name,
    position,
    posLabel,
    file,
    email,
    phone,
    city,
    tg,
    exp,
    totalExp,
    stack,
    edu,
    verdict,
    vc,
    criteria,
    summary,
    questions,
    status,
    dateAdded,
  ];
}
