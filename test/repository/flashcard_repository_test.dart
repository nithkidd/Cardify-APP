import 'package:flashcard/models/flashcard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlashcardRepository Tests', () {
    group('Difficulty Calculation', () {
      test('should return easy for score <= 2', () {
        expect(DifficultyLevel.fromScore(0), DifficultyLevel.easy);
        expect(DifficultyLevel.fromScore(1), DifficultyLevel.easy);
        expect(DifficultyLevel.fromScore(2), DifficultyLevel.easy);
      });

      test('should return medium for score 3', () {
        expect(DifficultyLevel.fromScore(3), DifficultyLevel.medium);
      });

      test('should return hard for score > 3', () {
        expect(DifficultyLevel.fromScore(4), DifficultyLevel.hard);
        expect(DifficultyLevel.fromScore(5), DifficultyLevel.hard);
        expect(DifficultyLevel.fromScore(10), DifficultyLevel.hard);
      });

      test('should clamp score below 0 to 0 (easy)', () {
        expect(DifficultyLevel.fromScore(-5), DifficultyLevel.easy);
        expect(DifficultyLevel.fromScore(-1), DifficultyLevel.easy);
      });

      test('should clamp score above 10 to 10 (hard)', () {
        expect(DifficultyLevel.fromScore(15), DifficultyLevel.hard);
        expect(DifficultyLevel.fromScore(100), DifficultyLevel.hard);
      });
    });

    group('Flashcard Enums', () {
      test('difficulty level enum should have correct values', () {
        expect(DifficultyLevel.easy.name, 'easy');
        expect(DifficultyLevel.medium.name, 'medium');
        expect(DifficultyLevel.hard.name, 'hard');
      });

      test('difficulty level times multiplier should be correct', () {
        expect(DifficultyLevel.easy.times, 1);
        expect(DifficultyLevel.medium.times, 3);
        expect(DifficultyLevel.hard.times, 5);
      });
    });
  });
}
