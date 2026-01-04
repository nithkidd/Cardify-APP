import 'package:flashcard/models/deck.dart';
import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/ui/widgets/deck/deck_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeckItem Widget Tests', () {
    late Deck testDeck;

    setUp(() {
      testDeck = Deck('deck-123', 'Science Deck', DeckCategory.science);
      testDeck.flashcards = [
        Flashcard(null, 'deck-123', 'Q1', 'A1', 0, DifficultyLevel.easy),
        Flashcard(null, 'deck-123', 'Q2', 'A2', 0, DifficultyLevel.easy),
      ];
    });

    testWidgets('should display deck name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeckItem(deck: testDeck, onTap: () {}),
          ),
        ),
      );

      expect(find.text('Science Deck'), findsOneWidget);
    });

    testWidgets('should display deck category', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeckItem(deck: testDeck, onTap: () {}),
          ),
        ),
      );

      expect(find.text('Science'), findsOneWidget);
    });

    testWidgets('should display flashcard count', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeckItem(deck: testDeck, onTap: () {}),
          ),
        ),
      );

      expect(find.text('2 Cards'), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeckItem(deck: testDeck, onTap: () => tapped = true),
          ),
        ),
      );

      await tester.tap(find.text('Science Deck'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('should show popup menu button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeckItem(
              deck: testDeck,
              onTap: () {},
              onEdit: () {},
              onDelete: () {},
            ),
          ),
        ),
      );

      expect(find.byType(PopupMenuButton<String>), findsOneWidget);
    });

    testWidgets('should show session buttons when deck has flashcards', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeckItem(deck: testDeck, onTap: () {}),
          ),
        ),
      );

      expect(find.text('Practice Stage'), findsOneWidget);
      expect(find.text('Special Stage'), findsOneWidget);
    });

    testWidgets('should not show session buttons when deck is empty', (
      WidgetTester tester,
    ) async {
      final emptyDeck = Deck('deck-456', 'Empty Deck', DeckCategory.math);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DeckItem(deck: emptyDeck, onTap: () {}),
          ),
        ),
      );

      expect(find.text('Practice Stage'), findsNothing);
      expect(find.text('Special Stage'), findsNothing);
    });
  });
}
