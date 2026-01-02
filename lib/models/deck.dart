import 'package:flashcard/models/flashcard.dart';
import 'package:uuid/uuid.dart';

enum DeckCategory { science, history, math, geography, general }

class Deck {
  String deckId;
  String name;
  DeckCategory category;
  int timesReviewed;
  String? lastReviewed;
  List<Flashcard> flashcards = [];

  Deck(
    String? deckId,
    this.name,
    this.timesReviewed,
    this.lastReviewed,
    this.category,
  ) : deckId = deckId ?? const Uuid().v4();  
}