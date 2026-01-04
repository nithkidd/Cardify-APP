import 'package:flashcard/data/repository/flashcard_repository_sql.dart';
import 'package:flashcard/models/flashcard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlashcardRepositorySql Tests', () {
    late FlashcardRepositorySql repository;

    setUp(() {
      repository = FlashcardRepositorySql();
    });

    group('Difficulty Calculation', () {
      test('should return easy for score <= 2', () {
        expect(repository.calculateDifficultyLevel(0), DifficultyLevel.easy);
        expect(repository.calculateDifficultyLevel(1), DifficultyLevel.easy);
        expect(repository.calculateDifficultyLevel(2), DifficultyLevel.easy);
      });

      test('should return medium for score 3', () {
        expect(repository.calculateDifficultyLevel(3), DifficultyLevel.medium);
      });

      test('should return hard for score > 3', () {
        expect(repository.calculateDifficultyLevel(4), DifficultyLevel.hard);
        expect(repository.calculateDifficultyLevel(5), DifficultyLevel.hard);
        expect(repository.calculateDifficultyLevel(10), DifficultyLevel.hard);
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
