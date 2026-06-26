import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'candidates_page.g.dart';

@JsonSerializable()
@immutable
final class CandidatesPage extends Equatable {
  const CandidatesPage({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
  });

  final List<CandidateModel> items;
  final int total;
  final int page;
  final int limit;

  factory CandidatesPage.fromJson(Map<String, dynamic> json) {
    return _$CandidatesPageFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CandidatesPageToJson(this);
  }

  @override
  List<Object?> get props => [items, total, page, limit];
}
