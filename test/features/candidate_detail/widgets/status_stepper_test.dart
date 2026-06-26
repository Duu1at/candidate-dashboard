import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/features/candidate_detail/widgets/status_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: AppTheme.light,
  home: Scaffold(body: child),
);

const _allStatuses = CandidateStatus.values;

void main() {
  group('StatusStepper', () {
    testWidgets('renders short label for every status', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const StatusStepper(
            statuses: _allStatuses,
            currentIndex: 0,
          ),
        ),
      );

      expect(find.text('Новый'), findsOneWidget);
      expect(find.text('Рассмотр.'), findsOneWidget);
      expect(find.text('Приглашён'), findsOneWidget);
      expect(find.text('Отклонён'), findsOneWidget);
    });

    testWidgets('no check icons when current is the first step', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const StatusStepper(
            statuses: _allStatuses,
            currentIndex: 0,
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsNothing);
    });

    testWidgets('one check icon when one step is past', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const StatusStepper(
            statuses: _allStatuses,
            currentIndex: 1,
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('three check icons when three steps are past', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const StatusStepper(
            statuses: _allStatuses,
            currentIndex: 3,
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsNWidgets(3));
    });

    testWidgets('all steps are past when currentIndex equals statuses length', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          const StatusStepper(
            statuses: _allStatuses,
            currentIndex: 4,
          ),
        ),
      );

      expect(find.byIcon(Icons.check), findsNWidgets(4));
    });

    testWidgets('two-step list: renders both labels', (tester) async {
      await tester.pumpWidget(
        _wrap(
          const StatusStepper(
            statuses: [CandidateStatus.newCandidate, CandidateStatus.review],
            currentIndex: 0,
          ),
        ),
      );

      expect(find.text('Новый'), findsOneWidget);
      expect(find.text('Рассмотр.'), findsOneWidget);
    });
  });
}
