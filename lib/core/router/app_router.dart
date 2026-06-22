import 'package:candidate_dashboard/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/candidate_detail/view/candidate_detail_screen.dart';
import '../../features/candidates_list/view/candidates_list_screen.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.init,
  routes: [
    GoRoute(
      path: AppRoutes.candidatesList,
      builder: (_, _) => const CandidatesListScreen(),
      routes: [
        GoRoute(
          path: AppRoutes.candidateDetail,
          builder: (_, _) => const CandidateDetailScreen(),
        ),
      ],
    ),
  ],
  errorBuilder:
      (_, _) =>
          const Scaffold(body: Center(child: Text('Страница не найдена'))),
);
