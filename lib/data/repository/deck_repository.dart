import 'dart:convert';
import 'package:flashcard/data/storage/storage_service.dart';
import 'package:flashcard/models/deck.dart';
import 'package:flashcard/models/flashcard.dart';

class DeckRepository {
  final StorageService _storageService = StorageService(fileName: 'decks.json');

  // ============ LOAD ============

  Future<List<Deck>> loadAll() async {
    final jsonString = await _storageService.read();

    // No saved data → return empty list
    if (jsonString == null) {
      return [];
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => Deck.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Error parsing decks: $e');
    }
  }

  Future<Deck?> loadById(String deckId) async {
    final decks = await loadAll();
    try {
      return decks.firstWhere((d) => d.deckId == deckId);
    } catch (e) {
      return null;
    }
  }

  // ============ SAVE ============

  Future<void> saveAll(List<Deck> decks) async {
    final jsonList = decks.map((deck) => deck.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _storageService.write(jsonString);
  }

  // ============ DECK OPERATIONS ============

  Future<void> addDeck(List<Deck> decks, Deck newDeck) async {
    decks.add(newDeck);
    await saveAll(decks);
  }

  Future<void> updateDeck(List<Deck> decks, Deck updatedDeck) async {
    final index = decks.indexWhere((d) => d.deckId == updatedDeck.deckId);
    if (index != -1) {
      decks[index] = updatedDeck;
      await saveAll(decks);
    }
  }

  Future<void> deleteDeck(List<Deck> decks, String deckId) async {
    decks.removeWhere((d) => d.deckId == deckId);
    await saveAll(decks);
  }

  // ============ FLASHCARD OPERATIONS ============

  Future<void> addFlashcard(
    List<Deck> decks,
    String deckId,
    Flashcard flashcard,
  ) async {
    final deck = decks.firstWhere((d) => d.deckId == deckId);
    deck.flashcards.add(flashcard);
    await saveAll(decks);
  }

  Future<void> updateFlashcard(
    List<Deck> decks,
    String deckId,
    Flashcard flashcard,
  ) async {
    final deck = decks.firstWhere((d) => d.deckId == deckId);
    final index = deck.flashcards.indexWhere(
      (f) => f.flashcardId == flashcard.flashcardId,
    );
    if (index != -1) {
      deck.flashcards[index] = flashcard;
      await saveAll(decks);
    }
  }

  Future<void> deleteFlashcard(
    List<Deck> decks,
    String deckId,
    String flashcardId,
  ) async {
    final deck = decks.firstWhere((d) => d.deckId == deckId);
    deck.flashcards.removeWhere((f) => f.flashcardId == flashcardId);
    await saveAll(decks);
  }

  // ============ RESET ============

  Future<void> clearAll() async {
    await _storageService.delete();
  }
}
