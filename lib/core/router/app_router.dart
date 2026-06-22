import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/candidate_detail/cubit/candidate_detail_cubit.dart';
import '../../features/candidate_detail/view/candidate_detail_screen.dart';
import '../../features/candidates_list/view/candidates_list_screen.dart';
import '../di/injection.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, _s) => const CandidatesListScreen(),
      routes: [
        GoRoute(
          path: 'candidate/:id',
          builder: (_, state) {
            final id = state.pathParameters['id']!;
            return BlocProvider(
              create: (_) => getIt<CandidateDetailCubit>()..load(id),
              child: const CandidateDetailScreen(),
            );
          },
        ),
      ],
    ),
  ],
  errorBuilder: (_, _s) => const Scaffold(
    body: Center(child: Text('Страница не найдена')),
  ),
);
