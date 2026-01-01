import 'package:uuid/uuid.dart';

var uuid = Uuid().v4();

enum DifficultyLevel { easy, medium, hard }

class Flashcard {
  String flashcardId;
  String deckId;
  String frontText;
  String backText;
  int difficultyScore;
  int correctCount;
  int incorrectCount;
  DifficultyLevel difficultyLevel;

  Flashcard(
    String? flashcardId,
    this.deckId,
    this.frontText,
    this.backText,
    this.difficultyScore,
    this.correctCount,
    this.incorrectCount,
    this.difficultyLevel,
  ) : flashcardId = flashcardId ?? uuid;
}
