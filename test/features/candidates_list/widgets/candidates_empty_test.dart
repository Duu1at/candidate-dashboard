import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: AppTheme.light,
  home: Scaffold(body: child),
);

void main() {
  group('CandidatesEmpty', () {
    testWidgets('with query: shows query in description text', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CandidatesEmpty(
            query: 'Иванов',
            onReset: () {},
          ),
        ),
      );

      expect(find.textContaining('«Иванов»'), findsOneWidget);
    });

    testWidgets('without query: shows filter-based description', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          CandidatesEmpty(
            query: '',
            onReset: () {},
          ),
        ),
      );

      expect(
        find.textContaining('соответствующих выбранным фильтрам'),
        findsOneWidget,
      );
    });

    testWidgets('without query: does not show query placeholder', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          CandidatesEmpty(
            query: '',
            onReset: () {},
          ),
        ),
      );

      expect(find.textContaining('«'), findsNothing);
    });

    testWidgets('shows Ничего не найдено heading', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CandidatesEmpty(
            query: '',
            onReset: () {},
          ),
        ),
      );

      expect(find.text('Ничего не найдено'), findsOneWidget);
    });

    testWidgets('reset button calls onReset', (tester) async {
      var called = false;
      await tester.pumpWidget(
        _wrap(
          CandidatesEmpty(
            query: '',
            onReset: () => called = true,
          ),
        ),
      );

      await tester.tap(find.text('Сбросить фильтры'));
      await tester.pump();

      expect(called, isTrue);
    });
  });
}
