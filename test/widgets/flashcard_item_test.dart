import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/ui/widgets/flashcard/flashcard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlashcardItem Widget Tests', () {
    late Flashcard testFlashcard;

    setUp(() {
      testFlashcard = Flashcard(
        'flashcard-123',
        'deck-123',
        'What is 2+2?',
        '4',
        0,
        DifficultyLevel.easy,
      );
    });

    testWidgets('should display front text label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: FlashcardItem(flashcard: testFlashcard)),
        ),
      );

      expect(find.text('Front:'), findsOneWidget);
    });

    testWidgets('should display back text label', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: FlashcardItem(flashcard: testFlashcard)),
        ),
      );

      expect(find.text('Back:'), findsOneWidget);
    });

    testWidgets('should display front text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: FlashcardItem(flashcard: testFlashcard)),
        ),
      );

      expect(find.text('What is 2+2?'), findsOneWidget);
    });

    testWidgets('should display back text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: FlashcardItem(flashcard: testFlashcard)),
        ),
      );

      expect(find.text('4'), findsOneWidget);
    });

    testWidgets('should show popup menu when callbacks are provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlashcardItem(
              flashcard: testFlashcard,
              onEdit: () {},
              onDelete: () {},
            ),
          ),
        ),
      );

      expect(find.byType(PopupMenuButton<String>), findsOneWidget);
    });

    testWidgets('should call onEdit when edit is selected', (
      WidgetTester tester,
    ) async {
      var editCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlashcardItem(
              flashcard: testFlashcard,
              onEdit: () => editCalled = true,
              onDelete: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();

      expect(editCalled, isTrue);
    });

    testWidgets('should call onDelete when delete is selected', (
      WidgetTester tester,
    ) async {
      var deleteCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FlashcardItem(
              flashcard: testFlashcard,
              onEdit: () {},
              onDelete: () => deleteCalled = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(deleteCalled, isTrue);
    });
  });
}
