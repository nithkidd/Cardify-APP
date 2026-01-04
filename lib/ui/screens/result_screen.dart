import 'package:flashcard/models/deck.dart';
import 'package:flashcard/models/practice_session.dart';
import 'package:flashcard/ui/screens/practice_session_screen.dart';
import 'package:flashcard/ui/widgets/button/add_button.dart';
import 'package:flashcard/ui/widgets/practice/practice_form.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/ui/widgets/button/session_button.dart';
import 'package:flashcard/ui/widgets/practice/result_item.dart';

class ResultScreen extends StatelessWidget {
  final String deckName;
  final int totalCards;
  final int knowCount;
  final int dontKnowCount;
  final Deck deck;

  const ResultScreen({
    super.key,
    required this.deckName,
    required this.totalCards,
    required this.knowCount,
    required this.dontKnowCount,
    required this.deck,
  });

  void startSession(BuildContext context, SessionType sessionType) async {
    if (sessionType == SessionType.special) {
      int? newDeckSize = await showModalBottomSheet<int>(
        isScrollControlled: false,
        context: context,
        builder: (c) => PracticeForm(deckSize: deck.flashcards.length),
      );
      if (newDeckSize == null) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PracticeSessionScreen(
            deck: deck,
            sessionType: sessionType,
            sessionSize: newDeckSize,
          ),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PracticeSessionScreen(deck: deck, sessionType: sessionType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (knowCount / totalCards * 100).toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Practice Results',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF204366),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Icon(
                Icons.check_circle_outline,
                size: 80,
                color: Color(0xFF204366),
              ),
              const SizedBox(height: 24),
              const Text(
                'Practice Complete!',
                style: TextStyle(
                  color: Color(0xFF204366),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Summary for deck: $deckName",
                style: const TextStyle(color: Colors.black87, fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const Text(
                "You've mastered",
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  color: Color(0xFF204366),
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  ResultStatCard(
                    label: "Memorized",
                    count: knowCount,
                    color: const Color(0xFF26A69A),
                  ),
                  ResultStatCard(
                    label: "Not Memorized",
                    count: dontKnowCount,
                    color: const Color(0xFFFF9800),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SessionButton(
                          "Practice Stage",
                          onTap: () =>
                              startSession(context, SessionType.practice),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SessionButton(
                          "Special Stage",
                          tooltipMessage: "Harder cards will appear more often",
                          onTap: () =>
                              startSession(context, SessionType.special),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: AddButton(
                      "Return to Decks",
                      color: Color(0xFF204366),
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
