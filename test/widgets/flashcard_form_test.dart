import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/ui/widgets/flashcard/flashcard_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlashcardForm Widget Tests', () {
    testWidgets('should display create mode UI when no flashcard is provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: FlashcardForm(deckId: 'deck-123')),
        ),
      );

      expect(find.text('Create a Flashcard'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
    });

    testWidgets('should display edit mode UI when flashcard is provided', (
      WidgetTester tester,
    ) async {
      final testFlashcard = Flashcard(
        'flashcard-123',
        'deck-123',
        'Front Text',
        'Back Text',
        0,
        DifficultyLevel.easy,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlashcardForm(deckId: 'deck-123', flashcard: testFlashcard),
          ),
        ),
      );

      expect(find.text('Edit a Flashcard'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('should pre-fill form fields when editing flashcard', (
      WidgetTester tester,
    ) async {
      final testFlashcard = Flashcard(
        'flashcard-123',
        'deck-123',
        'Existing Front',
        'Existing Back',
        2,
        DifficultyLevel.medium,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlashcardForm(deckId: 'deck-123', flashcard: testFlashcard),
          ),
        ),
      );

      final textFields = tester
          .widgetList<TextField>(find.byType(TextField))
          .toList();
      expect(textFields[0].controller?.text, 'Existing Front');
      expect(textFields[1].controller?.text, 'Existing Back');
    });

    testWidgets('should have front and back text fields', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: FlashcardForm(deckId: 'deck-123')),
        ),
      );

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Front Text'), findsOneWidget);
      expect(find.text('Back Text'), findsOneWidget);
    });

    testWidgets('should show cancel button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: FlashcardForm(deckId: 'deck-123')),
        ),
      );

      expect(find.text('Cancel'), findsOneWidget);
    });
  });
}
