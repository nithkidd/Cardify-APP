import 'package:flashcard/models/flashcard.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid().v4();

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
  ) : deckId = deckId ?? uuid;

  Map<String, dynamic> toJson() {
    return {
      'deckId': deckId,
      'name': name,
      'category': category.name,
      'timesReviewed': timesReviewed,
      'lastReviewed': lastReviewed,
      'flashcards': flashcards.map((f) => f.toJson()).toList(),
    };
  }

  factory Deck.fromJson(Map<String, dynamic> json) {
    var deck = Deck(
      json['deckId'],
      json['name'],
      json['timesReviewed'],
      json['lastReviewed'],
      DeckCategory.values.firstWhere(
        (e) => e.name == json['category'],
        orElse: () => DeckCategory.general,
      ),
    );
    deck.flashcards = (json['flashcards'] as List)
        .map((f) => Flashcard.fromJson(f))
        .toList();
    return deck;
  }
}
