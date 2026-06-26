import 'package:candidate_dashboard/core/core.dart';
import 'package:candidate_dashboard/features/candidates_list/candidates_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _wrap(Widget child) => MaterialApp(
  theme: AppTheme.light,
  home: Scaffold(body: child),
);

void main() {
  group('CandidatesSearchField', () {
    late TextEditingController controller;

    setUp(() => controller = TextEditingController());
    tearDown(() => controller.dispose());

    testWidgets('shows hint text when empty', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CandidatesSearchField(
            controller: controller,
            onChanged: (_) {},
            onClear: () {},
          ),
        ),
      );

      expect(find.text('Поиск по ФИО'), findsOneWidget);
    });

    testWidgets('clear button is hidden when field is empty', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CandidatesSearchField(
            controller: controller,
            onChanged: (_) {},
            onClear: () {},
          ),
        ),
      );

      expect(find.byIcon(Icons.clear_rounded), findsNothing);
    });

    testWidgets('clear button appears after entering text', (tester) async {
      await tester.pumpWidget(
        _wrap(
          CandidatesSearchField(
            controller: controller,
            onChanged: (_) {},
            onClear: () {},
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Иван');
      await tester.pump();

      expect(find.byIcon(Icons.clear_rounded), findsOneWidget);
    });

    testWidgets('onChanged is called with the typed text', (tester) async {
      String? lastValue;
      await tester.pumpWidget(
        _wrap(
          CandidatesSearchField(
            controller: controller,
            onChanged: (v) => lastValue = v,
            onClear: () {},
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Иван');
      await tester.pump();

      expect(lastValue, 'Иван');
    });

    testWidgets('tapping clear button calls onClear', (tester) async {
      var cleared = false;
      controller.text = 'Иван';

      await tester.pumpWidget(
        _wrap(
          CandidatesSearchField(
            controller: controller,
            onChanged: (_) {},
            onClear: () => cleared = true,
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.byIcon(Icons.clear_rounded));
      await tester.pump();

      expect(cleared, isTrue);
    });
  });
}
