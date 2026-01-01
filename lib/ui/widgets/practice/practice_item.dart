import 'package:flashcard/models/practice_session.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/models/flashcard.dart';

class PracticeItem extends StatelessWidget {
  const PracticeItem({
    super.key,
    required this.flashcard,
    required this.showAnswer,
    required this.onFlip,
  });

  final Flashcard flashcard;
  final bool showAnswer;
  final VoidCallback onFlip;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onFlip,
        child: Container(
          // width: double.infinity,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(32),
        //   decoration: BoxDecoration(
        //   color: const Color(0xFF1E1E1E),
        //   borderRadius: BorderRadius.circular(16),
        //   border: Border.all(
        //     color: showAnswer ? Colors.green : Colors.blue,
        //     width: 5,
        //   ),
        // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showAnswer ? flashcard.backText : flashcard.frontText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,

                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (!showAnswer)
                const Text(
                  'Tap to reveal answer',
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
                  decoration: TextDecoration.none,

                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}