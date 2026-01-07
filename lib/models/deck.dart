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

  // ============ MAPPERS ============
  /// Convert Deck to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'deckId': deckId,
      'name': name,
      'category': category.name,
    };
  }

  /// Create Deck from database Map
  factory Deck.fromMap(Map<String, dynamic> map) {
    return Deck(
      map['deckId'],
      map['name'],
      DeckCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => DeckCategory.general,
      ),
    );
  }
}