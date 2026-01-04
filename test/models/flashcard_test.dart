import 'package:flashcard/models/flashcard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Flashcard Model Tests', () {
    test('should create a flashcard with a generated ID when ID is null', () {
      final flashcard = Flashcard(
        null,
        'deck-123',
        'Front Text',
        'Back Text',
        0,
        DifficultyLevel.easy,
      );

      expect(flashcard.flashcardId, isNotEmpty);
      expect(flashcard.deckId, 'deck-123');
      expect(flashcard.frontText, 'Front Text');
      expect(flashcard.backText, 'Back Text');
      expect(flashcard.difficultyScore, 0);
      expect(flashcard.difficultyLevel, DifficultyLevel.easy);
    });

    test('should create a flashcard with a provided ID', () {
      const testId = 'flashcard-456';
      final flashcard = Flashcard(
        testId,
        'deck-123',
        'Question',
        'Answer',
        3,
        DifficultyLevel.medium,
      );

      expect(flashcard.flashcardId, testId);
      expect(flashcard.difficultyScore, 3);
      expect(flashcard.difficultyLevel, DifficultyLevel.medium);
    });

    test('should generate unique IDs for different flashcards', () {
      final flashcard1 = Flashcard(
        null,
        'deck-123',
        'Front 1',
        'Back 1',
        0,
        DifficultyLevel.easy,
      );
      final flashcard2 = Flashcard(
        null,
        'deck-123',
        'Front 2',
        'Back 2',
        0,
        DifficultyLevel.easy,
      );

      expect(flashcard1.flashcardId, isNot(equals(flashcard2.flashcardId)));
    });

    test('should support all difficulty levels', () {
      expect(DifficultyLevel.values.length, 3);
      expect(DifficultyLevel.values, contains(DifficultyLevel.easy));
      expect(DifficultyLevel.values, contains(DifficultyLevel.medium));
      expect(DifficultyLevel.values, contains(DifficultyLevel.hard));
    });

    test('difficulty level should have correct times multiplier', () {
      expect(DifficultyLevel.easy.times, 1);
      expect(DifficultyLevel.medium.times, 3);
      expect(DifficultyLevel.hard.times, 5);
    });

    test('should allow updating flashcard properties', () {
      final flashcard = Flashcard(
        null,
        'deck-123',
        'Initial Front',
        'Initial Back',
        0,
        DifficultyLevel.easy,
      );

      flashcard.frontText = 'Updated Front';
      flashcard.backText = 'Updated Back';
      flashcard.difficultyScore = 5;
      flashcard.difficultyLevel = DifficultyLevel.hard;

      expect(flashcard.frontText, 'Updated Front');
      expect(flashcard.backText, 'Updated Back');
      expect(flashcard.difficultyScore, 5);
      expect(flashcard.difficultyLevel, DifficultyLevel.hard);
    });
  });
}
