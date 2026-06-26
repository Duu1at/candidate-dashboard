import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
final class UpdateStatusParams extends Equatable {
  const UpdateStatusParams({
    required this.id,
    required this.status,
  });

  final String id;
  final String status;

  @override
  List<Object?> get props => [
    id,
    status,
  ];
}
