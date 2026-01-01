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
}

enum SessionType { practice, special }

class PracticeSession {
  String sessionId;
  String deckId;

  int sessionSize;
  String startTime;
  String? endTime;

  SessionType sessionType;

  PracticeSession(
    String? sessionId,
    this.deckId,
    this.sessionSize,
    this.startTime,
    this.endTime,
    this.sessionType,
  ) : sessionId = sessionId ?? uuid;
}
