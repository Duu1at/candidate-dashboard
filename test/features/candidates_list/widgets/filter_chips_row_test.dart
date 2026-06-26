import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: AppTheme.light,
  home: Scaffold(body: child),
);

void main() {
  group('FilterChipsRow', () {
    testWidgets('renders all four filter options', (tester) async {
      await tester.pumpWidget(
        _wrap(
          FilterChipsRow(
            selected: null,
            onSelected: (_) {},
            total: 0,
          ),
        ),
      );

      expect(find.text('Все'), findsOneWidget);
      expect(find.text('ПОДХОДИТ'), findsOneWidget);
      expect(find.text('ЧАСТИЧНО'), findsOneWidget);
      expect(find.text('НЕ ПОДХОДИТ'), findsOneWidget);
    });

    testWidgets('selected chip shows the total count', (tester) async {
      await tester.pumpWidget(
        _wrap(
          FilterChipsRow(
            selected: 'verdict-green',
            onSelected: (_) {},
            total: 7,
          ),
        ),
      );

      expect(find.text('7'), findsOneWidget);
    });

    testWidgets('non-selected chip does not show total count', (tester) async {
      await tester.pumpWidget(
        _wrap(
          FilterChipsRow(
            selected: null,
            onSelected: (_) {},
            total: 7,
          ),
        ),
      );

      // "Все" is selected so shows count; others do not add more
      expect(find.text('7'), findsOneWidget);

      // switch to verdict-green: only that chip shows count
      await tester.pumpWidget(
        _wrap(
          FilterChipsRow(
            selected: 'verdict-green',
            onSelected: (_) {},
            total: 3,
          ),
        ),
      );
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('tapping ПОДХОДИТ calls onSelected with verdict-green', (
      tester,
    ) async {
      String? selected;
      await tester.pumpWidget(
        _wrap(
          FilterChipsRow(
            selected: null,
            onSelected: (v) => selected = v,
            total: 0,
          ),
        ),
      );

      await tester.tap(find.text('ПОДХОДИТ'));
      await tester.pump();

      expect(selected, 'verdict-green');
    });

    testWidgets('tapping Все calls onSelected with null', (tester) async {
      const sentinel = 'sentinel';
      String? selected = sentinel;
      await tester.pumpWidget(
        _wrap(
          FilterChipsRow(
            selected: 'verdict-red',
            onSelected: (v) => selected = v,
            total: 0,
          ),
        ),
      );

      await tester.tap(find.text('Все'));
      await tester.pump();

      expect(selected, isNull);
    });

    testWidgets('tapping НЕ ПОДХОДИТ calls onSelected with verdict-red', (
      tester,
    ) async {
      String? selected;
      await tester.pumpWidget(
        _wrap(
          FilterChipsRow(
            selected: null,
            onSelected: (v) => selected = v,
            total: 0,
          ),
        ),
      );

      await tester.tap(find.text('НЕ ПОДХОДИТ'));
      await tester.pump();

      expect(selected, 'verdict-red');
    });
  });
}
