import 'package:flashcard/models/flashcard.dart';
import 'package:uuid/uuid.dart';

enum DeckCategory { science, history, math, geography, general }

class Deck {
  String deckId;
  String name;
  DeckCategory category;
  List<Flashcard> flashcards = [];

  Deck(
    String? deckId,
    this.name,
    this.category,
  ) : deckId = deckId ?? const Uuid().v4();  
}