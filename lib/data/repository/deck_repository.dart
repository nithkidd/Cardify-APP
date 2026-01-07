import 'package:flashcard/data/database/database_helper.dart';
import 'package:flashcard/data/repository/flashcard_repository.dart';
import 'package:flashcard/models/deck.dart';

class DeckRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final FlashcardRepository _flashcardRepository = FlashcardRepository();

  // ============ LOAD ALL DECKS ============
  Future<List<Deck>> loadAll() async {
    final db = await _dbHelper.database;

    final deckMaps = await db.query('decks', orderBy: 'createdAt DESC');

    List<Deck> decks = [];
    for (var deckMap in deckMaps) {
      final deck = Deck.fromMap(deckMap);
      deck.flashcards = await _flashcardRepository.loadByDeckId(deck.deckId);
      decks.add(deck);
    }

    return decks;
  }

  // ============ LOAD DECK BY ID ============
  Future<Deck?> loadById(String deckId) async {
    final db = await _dbHelper.database;

    final deckMaps = await db.query(
      'decks',
      where: 'deckId = ?',
      whereArgs: [deckId],
    );

    if (deckMaps.isEmpty) return null;

    final deck = Deck.fromMap(deckMaps.first);
    deck.flashcards = await _flashcardRepository.loadByDeckId(deckId);
    return deck;
  }

  // ============ ADD DECK ============
  Future<void> addDeck(Deck deck) async {
    final db = await _dbHelper.database;
    await db.insert('decks', deck.toMap());
  }

  // ============ UPDATE DECK ============
  Future<void> updateDeck(Deck deck) async {
    final db = await _dbHelper.database;
    await db.update(
      'decks',
      deck.toMap(),
      where: 'deckId = ?',
      whereArgs: [deck.deckId],
    );
  }

  // ============ DELETE DECK ============
  Future<void> deleteDeck(String deckId) async {
    await _flashcardRepository.deleteByDeckId(deckId);
    final db = await _dbHelper.database;
    await db.delete('decks', where: 'deckId = ?', whereArgs: [deckId]);
  }

  // ============ CLEAR ALL DATA ============
  Future<void> clearAll() async {
    final db = await _dbHelper.database;
    await db.delete('flashcards');
    await db.delete('decks');
  }
}
