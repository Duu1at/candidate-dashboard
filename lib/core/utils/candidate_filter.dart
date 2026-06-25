import 'package:candidate_dashboard/data/models/candidate_model.dart';

enum SortOption {
  name('По имени'),
  experience('По опыту'),
  dateAdded('По дате добавления');

  const SortOption(this.label);
  final String label;
}

List<CandidateModel> filterAndSort({
  required List<CandidateModel> candidates,
  required String query,
  required String? verdictFilter,
  required SortOption sortBy,
}) {
  final result = candidates.where((c) {
    final matchesQuery =
        query.isEmpty || c.name.toLowerCase().contains(query.toLowerCase());
    final matchesVerdict = verdictFilter == null || c.verdict == verdictFilter;
    return matchesQuery && matchesVerdict;
  }).toList();

  switch (sortBy) {
    case SortOption.name:
      result.sort((a, b) => a.name.compareTo(b.name));
    case SortOption.experience:
      result.sort(
        (a, b) => _parseYears(b.totalExp).compareTo(_parseYears(a.totalExp)),
      );
    case SortOption.dateAdded:
      result.sort((a, b) => (b.dateAdded ?? '').compareTo(a.dateAdded ?? ''));
  }

  return result;
}

double _parseYears(String totalExp) {
  final match = RegExp(r'[\d.]+').firstMatch(totalExp);
  return match != null ? double.tryParse(match.group(0)!) ?? 0.0 : 0.0;
}
