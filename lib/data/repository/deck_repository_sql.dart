import 'package:flashcard/data/database/database_helper.dart';
import 'package:flashcard/data/repository/flashcard_repository_sql.dart';
import 'package:flashcard/models/deck.dart';

class DeckRepositorySql {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final FlashcardRepositorySql _flashcardRepository = FlashcardRepositorySql();

  // ============ LOAD ALL DECKS ============
  Future<List<Deck>> loadAll() async {
    final db = await _dbHelper.database;

    final deckMaps = await db.query('decks', orderBy: 'createdAt DESC');

    List<Deck> decks = [];
    for (var deckMap in deckMaps) {
      final deck = _deckFromMap(deckMap);
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

    final deck = _deckFromMap(deckMaps.first);
    deck.flashcards = await _flashcardRepository.loadByDeckId(deckId);
    return deck;
  }

  // ============ ADD DECK ============
  Future<void> addDeck(Deck deck) async {
    final db = await _dbHelper.database;
    await db.insert('decks', _deckToMap(deck));
  }

  // ============ UPDATE DECK ============
  Future<void> updateDeck(Deck deck) async {
    final db = await _dbHelper.database;
    await db.update(
      'decks',
      _deckToMap(deck),
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

  // ============ CONVERTERS ============
  Map<String, dynamic> _deckToMap(Deck deck) {
    return {
      'deckId': deck.deckId,
      'name': deck.name,
      'category': deck.category.name,
    };
  }

  Deck _deckFromMap(Map<String, dynamic> map) {
    return Deck(
      map['deckId'],
      map['name'],
      DeckCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => DeckCategory.general,
      ),
    );
  }
}
