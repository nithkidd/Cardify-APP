import 'package:flashcard/data/database/database_helper.dart';
import 'package:flashcard/models/flashcard.dart';

class FlashcardRepositorySql {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // ============ LOAD FLASHCARDS BY DECK ============
  Future<List<Flashcard>> loadByDeckId(String deckId) async {
    final db = await _dbHelper.database;
    final flashcardMaps = await db.query(
      'flashcards',
      where: 'deckId = ?',
      whereArgs: [deckId],
    );
    return flashcardMaps.map((map) => _flashcardFromMap(map)).toList();
  }

  // ============ LOAD FLASHCARD BY ID ============
  Future<Flashcard?> loadById(String flashcardId) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'flashcards',
      where: 'flashcardId = ?',
      whereArgs: [flashcardId],
    );
    if (maps.isEmpty) return null;
    return _flashcardFromMap(maps.first);
  }

  // ============ ADD FLASHCARD ============
  Future<void> addFlashcard(
    List<Flashcard> flashcards,
    Flashcard flashcard,
  ) async {
    final db = await _dbHelper.database;
    await db.insert('flashcards', _flashcardToMap(flashcard));
    flashcards.add(flashcard); // Add to in-memory list
  }

  // ============ UPDATE FLASHCARD ============
  Future<void> updateFlashcard(Flashcard flashcard) async {
    final db = await _dbHelper.database;
    await db.update(
      'flashcards',
      _flashcardToMap(flashcard),
      where: 'flashcardId = ?',
      whereArgs: [flashcard.flashcardId],
    );
  }

  // ============ DELETE FLASHCARD ============
  Future<void> deleteFlashcard(String flashcardId) async {
    final db = await _dbHelper.database;
    await db.delete(
      'flashcards',
      where: 'flashcardId = ?',
      whereArgs: [flashcardId],
    );
  }

  // ============ DELETE ALL FLASHCARDS BY DECK ============
  Future<void> deleteByDeckId(String deckId) async {
    final db = await _dbHelper.database;
    await db.delete('flashcards', where: 'deckId = ?', whereArgs: [deckId]);
  }

  // ============ DIFFICULTY LOGIC ============
  DifficultyLevel calculateDifficultyLevel(int score) {
    if (score <= 2) {
      return DifficultyLevel.easy;
    } else if (score <= 3) {
      return DifficultyLevel.medium;
    } else {
      return DifficultyLevel.hard;
    }
  }

  Future<void> updateFlashcardDifficulty(Flashcard flashcard) async {
    flashcard.difficultyLevel = calculateDifficultyLevel(
      flashcard.difficultyScore,
    );
    await updateFlashcard(flashcard);
  }

  // ============ CONVERTERS ============
  Map<String, dynamic> _flashcardToMap(Flashcard flashcard) {
    return {
      'flashcardId': flashcard.flashcardId,
      'deckId': flashcard.deckId,
      'frontText': flashcard.frontText,
      'backText': flashcard.backText,
      'difficultyScore': flashcard.difficultyScore,
      'difficultyLevel': flashcard.difficultyLevel.name,
    };
  }

  Flashcard _flashcardFromMap(Map<String, dynamic> map) {
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
