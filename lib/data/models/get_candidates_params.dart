import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class GetCandidatesParams extends Equatable {
  const GetCandidatesParams({
    required this.page,
    required this.limit,
    this.search = '',
    this.filter,
    this.sort = 'date_added',
  });

  final int page;
  final int limit;
  final String search;
  final String? filter;
  final String sort;

  @override
  List<Object?> get props => [
    page,
    limit,
    search,
    filter,
    sort,
  ];
}
