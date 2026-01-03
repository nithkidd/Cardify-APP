import 'dart:math';
import 'package:flashcard/data/repository/deck_repository_sql.dart';
import 'package:flashcard/data/repository/practice_repository_sql.dart';
import 'package:flashcard/models/deck.dart';
import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/models/practice_session.dart';
import 'package:flashcard/ui/screens/result_screen.dart';
import 'package:flashcard/ui/widgets/practice/practice_item.dart';
import 'package:flutter/material.dart';

class PracticeSessionScreen extends StatefulWidget {
  final Deck deck;
  final SessionType sessionType;
  final int? sessionSize;
  const PracticeSessionScreen({
    super.key,
    required this.sessionType,
    required this.deck,
    this.sessionSize,
  });

  @override
  State<PracticeSessionScreen> createState() => _PracticeSessionScreenState();
}

class _PracticeSessionScreenState extends State<PracticeSessionScreen> {
  final DeckRepositorySql repository = DeckRepositorySql();
  final PracticeSessionRepositorySql practiceSessionRepo =  PracticeSessionRepositorySql();
  int _currentIndex = 0;
  bool _showAnswer = false;
  int _knowCount = 0;
  int _dontKnowCount = 0;
  late List<Flashcard> _flashcards;

  @override
  void initState() {
    super.initState();
    _flashcards = _setupCards();
  }

  List<Flashcard> _setupCards() {
    if (widget.sessionType != SessionType.special) {
      return List.from(widget.deck.flashcards);
    }

    return _pickCards();
  }

  List<Flashcard> _pickCards() {
    List<Flashcard> pool = [];

    for (var card in widget.deck.flashcards) {
      card.updateDifficultyLevel();
      for (int i = 0; i < card.difficultyLevel.times; i++) {
        pool.add(card);
      }
    }

    pool.shuffle();

    final random = Random();
    List<Flashcard> picked = [];

    for (int i = 0; i < widget.sessionSize!; i++) {
      picked.add(pool[random.nextInt(pool.length)]);
    }

    return picked;
  }

  void _handleAnswer(Flashcard flashcard, bool isKnown) async {
    if (isKnown) {
      _knowCount++;
      flashcard.difficultyScore -= 1;
   
    } else {
      _dontKnowCount++;
      flashcard.difficultyScore += 1;
    }

    await repository.updateFlashcard(flashcard);

    if (_currentIndex < _flashcards.length - 1) {
      setState(() {
        _currentIndex++;
        _showAnswer = false;
      });
    } else {

      await practiceSessionRepo.addSession(
        PracticeSession(
          null,
          widget.deck.name,
          widget.deck.deckId,
          _flashcards.length,
          widget.sessionType,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            deck: widget.deck,
            deckName: widget.deck.name,
            totalCards: _flashcards.length,
            knowCount: _knowCount,
            dontKnowCount: _dontKnowCount,
          ),
        ),
      );
    }
  }


  void _flipCard() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcard = _flashcards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Practice: ${widget.deck.name}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF070706),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF070706),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
              '${_currentIndex + 1} / ${_flashcards.length} Card',
              style: const TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              flashcard.difficultyLevel.name.toUpperCase(),
              style: TextStyle(
              color: flashcard.difficultyLevel == DifficultyLevel.easy
                ? Colors.green
                : flashcard.difficultyLevel == DifficultyLevel.medium
                ? Colors.orange
                : Colors.red,
              fontSize: 14,
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(32),
              child: PracticeItem(
              flashcard: flashcard,
              showAnswer: _showAnswer,
              onFlip: _flipCard,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(
                width: 150,
                height: 48,
                child: ElevatedButton.icon(
                onPressed: () => _handleAnswer(flashcard, false),
                label: const Text("I don't Know"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFAF0C0C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                  ),
                ),
                ),
              ),
              SizedBox(width: 24),
              SizedBox(
                width: 150,
                height: 48,
                child: ElevatedButton.icon(
                onPressed: () => _handleAnswer(flashcard, true),
                label: const Text("I Know"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF51A124),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                  ),
                ),
                ),
              ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
