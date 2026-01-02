import 'package:flashcard/models/deck.dart';
import 'package:flashcard/models/practice_session.dart';
import 'package:flashcard/ui/widgets/practice/practice_item.dart';
import 'package:flutter/material.dart';

class PracticeSessionScreen extends StatefulWidget {
  final Deck deck;
  final SessionType sessionType;

  const PracticeSessionScreen({
    super.key,
    required this.sessionType,
    required this.deck,
  });

  @override
  State<PracticeSessionScreen> createState() => _PracticeSessionScreenState();
}

class _PracticeSessionScreenState extends State<PracticeSessionScreen> {
  int _currentIndex = 0;
  bool _showAnswer = false;

  void _dontKnowButton() {
    if (_currentIndex < widget.deck.flashcards.length - 1) {
      setState(() {
        _currentIndex++;
        _showAnswer = false;
      });
    }
  }

  void _knowButton() {
    if (_currentIndex < widget.deck.flashcards.length - 1) {
      setState(() {
        _currentIndex++;
        _showAnswer = false;
      });
    }
  }

  void _flipCard() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {

    // if (widget.deck.flashcards.isEmpty) {
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: Text('Practice: ${widget.deck.name}'),
    //       backgroundColor: const Color(0xFF070706),
    //       iconTheme: const IconThemeData(color: Colors.white),
    //     ),
    //     backgroundColor: const Color(0xFF070706),
    //     body: const Center(
    //       child: Text(
    //         'No flashcards to practice',
    //         style: TextStyle(color: Colors.white70, fontSize: 18),
    //       ),
    //     ),
    //   );
    // }

    final flashcard = widget.deck.flashcards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
          title: Text('Practice: ${widget.deck.name}',  
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
              '${_currentIndex + 1} / ${widget.deck.flashcards.length} Card',
              style: const TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
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
                //dont know
                ElevatedButton.icon(
                  onPressed: _currentIndex < widget.deck.flashcards.length - 1
                      ? _dontKnowButton
                      : null,
                  label: const Text("I don't Know"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFAF0C0C),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),

                  SizedBox(width: 24,),
                //know
                ElevatedButton.icon(
                  onPressed: _currentIndex < widget.deck.flashcards.length - 1
                      ? _knowButton
                      : null,
                  label: const Text("I Know"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF51A124),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
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
