import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: AppTheme.light,
  home: Scaffold(body: child),
);

void main() {
  group('CandidatesError', () {
    testWidgets('shows the provided error message', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CandidatesError(
            message: 'Нет соединения с интернетом',
            onRetry: () {},
          ),
        ),
      );

      expect(find.text('Нет соединения с интернетом'), findsOneWidget);
    });

    testWidgets('retry button calls onRetry', (tester) async {
      var called = false;
      await tester.pumpWidget(
        _wrap(
          CandidatesError(
            message: 'Ошибка',
            onRetry: () => called = true,
          ),
        ),
      );

      await tester.tap(find.text('Повторить'));
      await tester.pump();

      expect(called, isTrue);
    });

    testWidgets('shows error icon', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CandidatesError(
            message: 'Ошибка',
            onRetry: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
    });
  });
}
