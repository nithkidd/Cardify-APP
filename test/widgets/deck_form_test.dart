import 'package:flashcard/models/deck.dart';
import 'package:flashcard/ui/widgets/deck/deck_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeckForm Widget Tests', () {
    testWidgets('should display create mode UI when no deck is provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: DeckForm())),
      );

      expect(find.text('Create a Deck'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
    });

    testWidgets('should display edit mode UI when deck is provided', (
      WidgetTester tester,
    ) async {
      final testDeck = Deck('test-id', 'Test Deck', DeckCategory.science);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: DeckForm(deck: testDeck)),
        ),
      );

      expect(find.text('Edit Deck'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('should pre-fill form fields when editing deck', (
      WidgetTester tester,
    ) async {
      final testDeck = Deck('test-id', 'Existing Deck', DeckCategory.history);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: DeckForm(deck: testDeck)),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect((textField.controller?.text), 'Existing Deck');
    });

    testWidgets('should show cancel button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: DeckForm())),
      );

      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('should close form when cancel is tapped', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (c) => const DeckForm(),
                  );
                },
                child: const Text('Open Form'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open Form'));
      await tester.pumpAndSettle();

      expect(find.text('Create a Deck'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('Create a Deck'), findsNothing);
    });
  });
}
