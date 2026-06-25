import 'package:candidate_dashboard/data/models/candidate_model.dart';

class CandidatesPage {
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
    return CandidatesPage(
      items: (json['items'] as List<dynamic>)
          .map((e) => CandidateModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      limit: json['limit'] as int,
    );
  }
}
