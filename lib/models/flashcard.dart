import 'package:uuid/uuid.dart';

enum DifficultyLevel {
  easy(1),    
  medium(3),
  hard(5);    

  final int times;
  const DifficultyLevel(this.times);
}

class Flashcard {
  String flashcardId;
  String deckId;
  String frontText;
  String backText;
  int difficultyScore;
  DifficultyLevel difficultyLevel;

  Flashcard(
    String? flashcardId,
    this.deckId,
    this.frontText,
    this.backText,
    this.difficultyScore,
    this.difficultyLevel,
  ) : flashcardId = flashcardId ?? const Uuid().v4();

}