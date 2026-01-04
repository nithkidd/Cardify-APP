import 'package:flashcard/models/deck.dart';
import 'package:flashcard/models/flashcard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Deck Model Tests', () {
    test('should create a deck with a generated ID when ID is null', () {
      final deck = Deck(null, 'Test Deck', DeckCategory.science);

      expect(deck.deckId, isNotEmpty);
      expect(deck.name, 'Test Deck');
      expect(deck.category, DeckCategory.science);
      expect(deck.flashcards, isEmpty);
    });

    test('should create a deck with a provided ID', () {
      const testId = 'test-deck-123';
      final deck = Deck(testId, 'Test Deck', DeckCategory.history);

      expect(deck.deckId, testId);
      expect(deck.name, 'Test Deck');
      expect(deck.category, DeckCategory.history);
    });

    test('should allow adding flashcards to deck', () {
      final deck = Deck(null, 'Test Deck', DeckCategory.math);
      final flashcard = Flashcard(
        null,
        deck.deckId,
        'Question',
        'Answer',
        0,
        DifficultyLevel.easy,
      );

      deck.flashcards.add(flashcard);

      expect(deck.flashcards.length, 1);
      expect(deck.flashcards.first.frontText, 'Question');
    });

    test('should generate unique IDs for different decks', () {
      final deck1 = Deck(null, 'Deck 1', DeckCategory.science);
      final deck2 = Deck(null, 'Deck 2', DeckCategory.history);

      expect(deck1.deckId, isNot(equals(deck2.deckId)));
    });

    test('should support all deck categories', () {
      expect(DeckCategory.values.length, 5);
      expect(DeckCategory.values, contains(DeckCategory.science));
      expect(DeckCategory.values, contains(DeckCategory.history));
      expect(DeckCategory.values, contains(DeckCategory.math));
      expect(DeckCategory.values, contains(DeckCategory.geography));
      expect(DeckCategory.values, contains(DeckCategory.general));
    });
  });
}
