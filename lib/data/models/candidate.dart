import 'package:freezed_annotation/freezed_annotation.dart';

part 'candidate.freezed.dart';
part 'candidate.g.dart';

List<List<String>> _expFromJson(List<dynamic> json) =>
    json.map((e) => List<String>.from(e as List)).toList();

List<dynamic> _expToJson(List<List<String>> list) => list;

enum CandidateStatus {
  newCandidate('new', 'Новый'),
  review('review', 'На рассмотрении'),
  invited('invited', 'Приглашён'),
  rejected('rejected', 'Отклонён');

  const CandidateStatus(this.value, this.label);
  final String value;
  final String label;

  static CandidateStatus fromValue(String value) => CandidateStatus.values
      .firstWhere((s) => s.value == value, orElse: () => CandidateStatus.newCandidate);
}

@freezed
abstract class Candidate with _$Candidate {
  const factory Candidate({
    required String id,
    required String name,
    required String position,
    @JsonKey(name: 'pos_label') required String posLabel,
    required String file,
    required String email,
    required String phone,
    required String city,
    required String tg,
    @JsonKey(fromJson: _expFromJson, toJson: _expToJson)
    required List<List<String>> exp,
    @JsonKey(name: 'total_exp') required String totalExp,
    required String stack,
    required String edu,
    required String verdict,
    required String vc,
    @JsonKey(fromJson: _expFromJson, toJson: _expToJson)
    required List<List<String>> criteria,
    required String summary,
    required List<String> questions,
    @Default('new') String status,
    @JsonKey(name: 'date_added') String? dateAdded,
  }) = _Candidate;

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);
}
