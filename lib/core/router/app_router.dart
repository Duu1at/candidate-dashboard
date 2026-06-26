import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidate_detail/candidate_detail.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.candidatesList,
  routes: [
    GoRoute(
      path: AppRoutes.candidatesList,
      builder: (_, _) => const CandidatesListView(),
      routes: [
        GoRoute(
          path: AppRoutes.candidateDetail,
          builder: (_, state) {
            final id = state.pathParameters['id']!;
            return CandidateDetailView(id: id);
          },
        ),
      ],
    ),
  ],
  errorBuilder: (_, _) =>
      const Scaffold(body: Center(child: Text('Страница не найдена'))),
);
