import 'package:flashcard/data/database/database_helper.dart';
import 'package:flashcard/models/flashcard.dart';

class FlashcardRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // ============ LOAD FLASHCARDS BY DECK ============
  Future<List<Flashcard>> loadByDeckId(String deckId) async {
    final db = await _dbHelper.database;
    final flashcardMaps = await db.query(
      'flashcards',
      where: 'deckId = ?',
      whereArgs: [deckId],
    );
    return flashcardMaps.map((map) => Flashcard.fromMap(map)).toList();
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
    return Flashcard.fromMap(maps.first);
  }
  // ============ ADD FLASHCARD ============
  Future<void> addFlashcard(Flashcard flashcard) async {
    final db = await _dbHelper.database;
    await db.insert('flashcards', flashcard.toMap());
  }

  // ============ UPDATE FLASHCARD ============
  Future<void> updateFlashcard(Flashcard flashcard) async {
    final db = await _dbHelper.database;
    await db.update(
      'flashcards',
      flashcard.toMap(),
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
}
