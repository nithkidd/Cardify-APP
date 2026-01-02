import 'package:flashcard/models/deck.dart';
import 'package:flashcard/models/practice_session.dart';
import 'package:flashcard/ui/screens/practice_session_screen.dart';
import 'package:flashcard/ui/widgets/session_button.dart';
import 'package:flutter/material.dart';

class DeckItem extends StatelessWidget {
  const DeckItem({super.key, required this.deck, required this.onTap});

  final Deck deck;
  final VoidCallback? onTap;

  void startSession(BuildContext context, SessionType sessionType) {
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              deck.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                deck.category.name,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${deck.flashcards.length} Cards',
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
            if (deck.flashcards.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  PrimarySessionButton(
                    "Practice Session",
                    onTap: () => startSession(context, SessionType.practice),
                  ),
                  const SizedBox(width: 8),
                  PrimarySessionButton(
                    "Special Session",
                    onTap: () => startSession(context, SessionType.special),
                    tooltipMessage:
                        "This stage the harder card will appear more",
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
