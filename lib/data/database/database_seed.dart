import 'package:sqflite/sqflite.dart';

/// Database seed data for initial application setup
class DatabaseSeed {
  /// Seeds the database with initial mock data
  static Future<void> seedData(Database db) async {
    // Seed Spanish Vocabulary deck
    await db.insert('decks', {
      'deckId': '1',
      'name': 'Spanish Vocabulary',
      'category': 'general',
    });
    await db.insert('flashcards', {
      'flashcardId': '1-1',
      'deckId': '1',
      'frontText': 'Hello',
      'backText': 'Hola',
      'difficultyScore': 0,
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '1-2',
      'deckId': '1',
      'frontText': 'Goodbye',
      'backText': 'Adiós',
      'difficultyScore': 1,
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '1-3',
      'deckId': '1',
      'frontText': 'Thank you',
      'backText': 'Gracias',
      'difficultyScore': 2,
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '1-4',
      'deckId': '1',
      'frontText': 'Please',
      'backText': 'Por favor',
      'difficultyScore': 3,
      'difficultyLevel': 'medium',
    });
    await db.insert('flashcards', {
      'flashcardId': '1-5',
      'deckId': '1',
      'frontText': 'Good morning',
      'backText': 'Buenos días',
      'difficultyScore': 3,
      'difficultyLevel': 'medium',
    });

    // Seed Math Formulas deck
    await db.insert('decks', {
      'deckId': '2',
      'name': 'Math Formulas',
      'category': 'math',
    });
    await db.insert('flashcards', {
      'flashcardId': '2-1',
      'deckId': '2',
      'frontText': 'Pythagorean theorem',
      'backText': 'a² + b² = c²',
      'difficultyScore': 3,
      'difficultyLevel': 'medium',
    });
    await db.insert('flashcards', {
      'flashcardId': '2-2',
      'deckId': '2',
      'frontText': 'Area of a circle',
      'backText': 'A = πr²',
      'difficultyScore': 1,
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '2-3',
      'deckId': '2',
      'frontText': 'Quadratic formula',
      'backText': 'x = (-b ± √(b²-4ac)) / 2a',
      'difficultyScore': 5,
      'difficultyLevel': 'hard',
    });

    // Seed History Facts deck
    await db.insert('decks', {
      'deckId': '3',
      'name': 'History Facts',
      'category': 'history',
    });
    await db.insert('flashcards', {
      'flashcardId': '3-1',
      'deckId': '3',
      'frontText': 'When did World War II end?',
      'backText': '1945',
      'difficultyScore': 0,
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '3-2',
      'deckId': '3',
      'frontText': 'Who was the first president of the United States?',
      'backText': 'George Washington',
      'difficultyScore': 1,
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '3-3',
      'deckId': '3',
      'frontText': 'What year did the French Revolution begin?',
      'backText': '1789',
      'difficultyScore': 3,
      'difficultyLevel': 'medium',
    });
    await db.insert('flashcards', {
      'flashcardId': '3-4',
      'deckId': '3',
      'frontText': 'Who discovered America?',
      'backText': 'Christopher Columbus (1492)',
      'difficultyScore': 2,
      'difficultyLevel': 'easy',
    });
    await db.insert('flashcards', {
      'flashcardId': '3-5',
      'deckId': '3',
      'frontText': 'What was the capital of the Roman Empire?',
      'backText': 'Rome',
      'difficultyScore': 0,
      'difficultyLevel': 'easy',
    });
  }
}
