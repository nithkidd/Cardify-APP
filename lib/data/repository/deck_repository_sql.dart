import 'dart:async';
import 'package:flashcard/data/database/database_service.dart';
import 'package:flashcard/models/deck.dart';
import 'package:flashcard/models/flashcard.dart';

class DeckRepositorySql {
  final DatabaseService _dbService = DatabaseService();

  // Stream controller for real-time updates
  final _decksController = StreamController<List<Deck>>.broadcast();
  Stream<List<Deck>> get decksStream => _decksController.stream;

  // ============ NOTIFY LISTENERS ============
  Future<void> _notifyListeners() async {
    final decks = await loadAll();
    _decksController.add(decks);
  }

  // ============ LOAD ALL DECKS ============
  Future<List<Deck>> loadAll() async {
    final db = await _dbService.database;

    // Get all decks
    final deckMaps = await db.query('decks', orderBy: 'createdAt DESC');

    List<Deck> decks = [];
    for (var deckMap in deckMaps) {
      // Get flashcards for each deck
      final flashcardMaps = await db.query(
        'flashcards',
        where: 'deckId = ?',
        whereArgs: [deckMap['deckId']],
      );

      final deck = _deckFromMap(deckMap);
      deck.flashcards = flashcardMaps.map((f) => _flashcardFromMap(f)).toList();
      decks.add(deck);
    }

    return decks;
  }

  // ============ LOAD DECK BY ID ============
  Future<Deck?> loadById(String deckId) async {
    final db = await _dbService.database;

    final deckMaps = await db.query(
      'decks',
      where: 'deckId = ?',
      whereArgs: [deckId],
    );

    if (deckMaps.isEmpty) return null;

    final flashcardMaps = await db.query(
      'flashcards',
      where: 'deckId = ?',
      whereArgs: [deckId],
    );

    final deck = _deckFromMap(deckMaps.first);
    deck.flashcards = flashcardMaps.map((f) => _flashcardFromMap(f)).toList();
    return deck;
  }

  // ============ ADD DECK ============
  Future<void> addDeck(Deck deck) async {
    final db = await _dbService.database;

    await db.insert('decks', _deckToMap(deck));

    // Insert flashcards if any
    for (var flashcard in deck.flashcards) {
      await db.insert('flashcards', _flashcardToMap(flashcard));
    }

    await _notifyListeners();
  }

  // ============ UPDATE DECK ============
  Future<void> updateDeck(Deck deck) async {
    final db = await _dbService.database;

    await db.update(
      'decks',
      _deckToMap(deck),
      where: 'deckId = ?',
      whereArgs: [deck.deckId],
    );

    await _notifyListeners();
  }

  // ============ DELETE DECK ============
  Future<void> deleteDeck(String deckId) async {
    final db = await _dbService.database;

    // Delete flashcards first (or use CASCADE)
    await db.delete('flashcards', where: 'deckId = ?', whereArgs: [deckId]);
    await db.delete('decks', where: 'deckId = ?', whereArgs: [deckId]);

    await _notifyListeners();
  }

  // ============ ADD FLASHCARD ============
  Future<void> addFlashcard(Flashcard flashcard) async {
    final db = await _dbService.database;

    await db.insert('flashcards', _flashcardToMap(flashcard));

    await _notifyListeners();
  }

  // ============ UPDATE FLASHCARD ============
  Future<void> updateFlashcard(Flashcard flashcard) async {
    final db = await _dbService.database;

    await db.update(
      'flashcards',
      _flashcardToMap(flashcard),
      where: 'flashcardId = ?',
      whereArgs: [flashcard.flashcardId],
    );

    await _notifyListeners();
  }

  // ============ DELETE FLASHCARD ============
  Future<void> deleteFlashcard(String flashcardId) async {
    final db = await _dbService.database;

    await db.delete(
      'flashcards',
      where: 'flashcardId = ?',
      whereArgs: [flashcardId],
    );

    await _notifyListeners();
  }

  // ============ BATCH INSERT (for initial data) ============
  Future<void> insertInitialData(List<Deck> decks) async {
    final db = await _dbService.database;

    await db.transaction((txn) async {
      for (var deck in decks) {
        await txn.insert('decks', _deckToMap(deck));
        for (var flashcard in deck.flashcards) {
          await txn.insert('flashcards', _flashcardToMap(flashcard));
        }
      }
    });

    await _notifyListeners();
  }

  // ============ CLEAR ALL DATA ============
  Future<void> clearAll() async {
    final db = await _dbService.database;

    await db.delete('flashcards');
    await db.delete('decks');

    await _notifyListeners();
  }

  // ============ CONVERTERS ============
  Map<String, dynamic> _deckToMap(Deck deck) {
    return {
      'deckId': deck.deckId,
      'name': deck.name,
      'category': deck.category.name,
      'timesReviewed': deck.timesReviewed,
      'lastReviewed': deck.lastReviewed,
    };
  }

  Deck _deckFromMap(Map<String, dynamic> map) {
    return Deck(
      map['deckId'],
      map['name'],
      map['timesReviewed'] ?? 0,
      map['lastReviewed'],
      DeckCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => DeckCategory.general,
      ),
    );
  }

  Map<String, dynamic> _flashcardToMap(Flashcard flashcard) {
    return {
      'flashcardId': flashcard.flashcardId,
      'deckId': flashcard.deckId,
      'frontText': flashcard.frontText,
      'backText': flashcard.backText,
      'difficultyScore': flashcard.difficultyScore,
      'correctCount': flashcard.correctCount,
      'incorrectCount': flashcard.incorrectCount,
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
      map['correctCount'] ?? 0,
      map['incorrectCount'] ?? 0,
      DifficultyLevel.values.firstWhere(
        (e) => e.name == map['difficultyLevel'],
        orElse: () => DifficultyLevel.easy,
      ),
    );
  }

  // ============ DISPOSE ============
  void dispose() {
    _decksController.close();
  }
}
