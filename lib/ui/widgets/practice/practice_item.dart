import 'package:flutter/material.dart';
import 'package:flashcard/models/flashcard.dart';
import 'package:flip_card/flip_card.dart';

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
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 500,
        onFlip: onFlip,
        flipOnTouch: true,
        front: _buildCard(
          context: context,
          text: flashcard.frontText,
          isQuestion: true,
        ),
        back: _buildCard(
          context: context,
          text: flashcard.backText,
          isQuestion: false,
        ),
      ),
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String text,
    required bool isQuestion,
  }) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isQuestion ? Colors.blue : Colors.green,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(77),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          if (isQuestion) ...[
            const SizedBox(height: 16),
            const Text(
              'Tap to reveal answer',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 12,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
