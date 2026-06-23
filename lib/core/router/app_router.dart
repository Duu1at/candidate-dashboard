import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/candidate_detail/view/candidate_detail_screen.dart';
import '../../features/candidates_list/view/candidates_list_view.dart';
import 'app_routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.candidatesList,
  routes: [
    GoRoute(
      path: AppRoutes.candidatesList,
      builder: (_, _) => const CandidatesListView(),
      routes: [
        GoRoute(
          path: AppRoutes.candidateDetail,
          builder: (_, _) => const CandidateDetailScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (_, _) =>
      const Scaffold(body: Center(child: Text('Страница не найдена'))),
);
