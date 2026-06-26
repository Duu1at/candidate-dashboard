enum CandidateStatus {
  newCandidate('new', 'Новый'),
  review('review', 'На рассмотрении'),
  invited('invited', 'Приглашён'),
  rejected('rejected', 'Отклонён');

  const CandidateStatus(this.value, this.label);
  final String value;
  final String label;

  static CandidateStatus fromValue(String value) {
    return CandidateStatus.values.firstWhere(
      (s) => s.value == value,
      orElse: () => CandidateStatus.newCandidate,
    );
  }
}
