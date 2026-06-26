import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/data/data.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: AppTheme.light,
  home: Scaffold(body: child),
);

CandidateModel _candidate({String stack = 'Flutter, Dart'}) => CandidateModel(
  id: '1',
  name: 'Иван Иванов',
  position: 'Flutter Developer',
  posLabel: 'Middle',
  file: '',
  email: 'ivan@example.com',
  phone: '+7 000 000 00 00',
  city: 'Бишкек',
  tg: '@ivan',
  exp: const [],
  totalExp: '3 года',
  stack: stack,
  edu: 'КГТУ',
  verdict: 'Рекомендован',
  vc: 'verdict-green',
  criteria: const [],
  summary: '',
  questions: const [],
  status: 'new',
  dateAdded: '2024-01-01',
);

void main() {
  group('CandidateCard', () {
    testWidgets('shows candidate name', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CandidateCard(
            candidate: _candidate(),
            onTap: () {},
          ),
        ),
      );

      expect(find.text('Иван Иванов'), findsOneWidget);
    });

    testWidgets('shows city and total experience', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CandidateCard(
            candidate: _candidate(),
            onTap: () {},
          ),
        ),
      );

      expect(find.text('Бишкек · 3 года'), findsOneWidget);
    });

    testWidgets('shows verdict text', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CandidateCard(
            candidate: _candidate(),
            onTap: () {},
          ),
        ),
      );

      expect(find.text('Рекомендован'), findsOneWidget);
    });

    testWidgets('shows up to 4 stack tags', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CandidateCard(
            candidate: _candidate(stack: 'Flutter, Dart, Firebase, Hive'),
            onTap: () {},
          ),
        ),
      );

      expect(find.text('Flutter'), findsOneWidget);
      expect(find.text('Dart'), findsOneWidget);
      expect(find.text('Firebase'), findsOneWidget);
      expect(find.text('Hive'), findsOneWidget);
      expect(find.textContaining('+'), findsNothing);
    });

    testWidgets('shows overflow label when stack has more than 4 tags', (
      tester,
    ) async {
      await tester.pumpWidget(
        _wrap(
          CandidateCard(
            candidate: _candidate(stack: 'Flutter, Dart, Firebase, Hive, BLoC'),
            onTap: () {},
          ),
        ),
      );

      expect(find.text('+1'), findsOneWidget);
    });

    testWidgets('onTap is called when card is tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        _wrap(
          CandidateCard(
            candidate: _candidate(),
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.text('Иван Иванов'));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
