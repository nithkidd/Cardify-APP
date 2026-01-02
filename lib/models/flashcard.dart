import 'package:flashcard/models/deck.dart';

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

  Map<String, dynamic> toJson() {
    return {
      'flashcardId': flashcardId,
      'deckId': deckId,
      'frontText': frontText,
      'backText': backText,
      'difficultyScore': difficultyScore,  
      'correctCount': correctCount,
      'incorrectCount': incorrectCount,
      'difficultyLevel': difficultyLevel.name,  
    };
  }

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      json['flashcardId'],
      json['deckId'],
      json['frontText'],
      json['backText'],
      json['difficultyScore'],  
      json['correctCount'],
      json['incorrectCount'],
      DifficultyLevel.values.firstWhere(
        (e) => e.name == json['difficultyLevel'],  
        orElse: () => DifficultyLevel.easy,
      ),
    );
  }
}