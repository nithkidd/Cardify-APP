import 'package:uuid/uuid.dart';

enum DifficultyLevel {
  easy(1),
  medium(3),
  hard(5);

  final int times;
  const DifficultyLevel(this.times);

  static DifficultyLevel fromScore(int score) {
    if (score <= 2) {
      return DifficultyLevel.easy;
    } else if (score <= 3) {
      return DifficultyLevel.medium;
    } else {
      return DifficultyLevel.hard;
    }
  }
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

  
  // ============ MAPPERS ============
  /// Convert Flashcard to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'flashcardId': flashcardId,
      'deckId': deckId,
      'frontText': frontText,
      'backText': backText,
      'difficultyScore': difficultyScore,
      'difficultyLevel': difficultyLevel.name,
    };
  }

  /// Create Flashcard from database Map
  factory Flashcard.fromMap(Map<String, dynamic> map) {
    return Flashcard(
      map['flashcardId'],
      map['deckId'],
      map['frontText'],
      map['backText'],
      map['difficultyScore'] ?? 0,
      DifficultyLevel.values.firstWhere(
        (e) => e.name == map['difficultyLevel'],
        orElse: () => DifficultyLevel.easy,
      ),
    );
  }

}
