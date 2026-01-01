import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/models/deck.dart';

List<Deck> getMockDecks() {
  var spanishDeck = Deck(
    '1',
    'Spanish Vocabulary',
    5,
    '2025-12-28',
    DeckCategory.general,
  );
  spanishDeck.flashcards = [
    Flashcard(null, '1', 'Hello', 'Hola', 0, 0, 0, DifficultyLevel.easy),
    Flashcard(null, '1', 'Goodbye', 'Adiós', 0, 0, 0, DifficultyLevel.easy),
    Flashcard(null, '1', 'Thank you', 'Gracias', 0, 0, 0, DifficultyLevel.easy),
    Flashcard(
      null,
      '1',
      'Please',
      'Por favor',
      0,
      0,
      0,
      DifficultyLevel.medium,
    ),
    Flashcard(null, '1', 'Goodbye', 'Adiós', 0, 0, 0, DifficultyLevel.easy),
    Flashcard(null, '1', 'Thank you', 'Gracias', 0, 0, 0, DifficultyLevel.easy),
    Flashcard(
      null,
      '1',
      'Please',
      'Por favor',
      0,
      0,
      0,
      DifficultyLevel.medium,
    ),
    Flashcard(
      null,
      '1',
      'Good morning',
      'Buenos días',
      0,
      0,
      0,
      DifficultyLevel.medium,
    ),
  ];

  // Create Math Formulas deck with cards
  var mathDeck = Deck('2', 'Math Formulas', 3, '2025-12-27', DeckCategory.math);
  mathDeck.flashcards = [
    Flashcard(
      null,
      '2',
      'Pythagorean theorem',
      'a² + b² = c²',
      0,
      0,
      0,
      DifficultyLevel.medium,
    ),
    Flashcard(
      null,
      '2',
      'Area of a circle',
      'A = πr²',
      0,
      0,
      0,
      DifficultyLevel.easy,
    ),
    Flashcard(
      null,
      '2',
      'Quadratic formula',
      'x = (-b ± √(b²-4ac)) / 2a',
      0,
      0,
      0,
      DifficultyLevel.hard,
    ),
  ];

  // Create History Facts deck with cards
  var historyDeck = Deck(
    '3',
    'History Facts',
    7,
    '2025-12-26',
    DeckCategory.history,
  );
  historyDeck.flashcards = [
    Flashcard(
      null,
      '3',
      'When did World War II end?',
      '1945',
      0,
      0,
      0,
      DifficultyLevel.easy,
    ),
    Flashcard(
      null,
      '3',
      'Who was the first president of the United States?',
      'George Washington',
      0,
      0,
      0,
      DifficultyLevel.easy,
    ),
    Flashcard(
      null,
      '3',
      'What year did the French Revolution begin?',
      '1789',
      0,
      0,
      0,
      DifficultyLevel.medium,
    ),
    Flashcard(
      null,
      '3',
      'Who discovered America?',
      'Christopher Columbus (1492)',
      0,
      0,
      0,
      DifficultyLevel.easy,
    ),
    Flashcard(
      null,
      '3',
      'What was the capital of the Roman Empire?',
      'Rome',
      0,
      0,
      0,
      DifficultyLevel.easy,
    ),
  ];

  return [spanishDeck, mathDeck, historyDeck];
}
