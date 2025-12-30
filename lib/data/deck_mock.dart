import 'package:flashcard/models/deck.dart';

List<Deck> getMockDecks() {
  return [
    Deck(
      '1',
      'Spanish Vocabulary',
      5,
      '2025-12-28',
      DeckCategory.GENERAL,
    ),
    Deck(
      '2',
      'Math Formulas',
      3,
      '2025-12-27',
      DeckCategory.MATH,
    ),
    Deck(
      '3',
      'History Facts',
      7,
      '2025-12-26',
      DeckCategory.HISTORY,
    ),
    
  ];
}
