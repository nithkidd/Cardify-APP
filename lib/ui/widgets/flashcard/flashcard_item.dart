import 'package:flashcard/models/flashcard.dart';
import 'package:flutter/material.dart';

class FlashcardItem extends StatelessWidget {
  const FlashcardItem({super.key, required this.flashcard});

  final Flashcard flashcard;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Front:',
            style: TextStyle(
              color: Color(0xFF204366),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            flashcard.frontText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black87, fontSize: 16),
          ),
          const SizedBox(height: 12),
          const Text(
            'Back:',
            style: TextStyle(
              color: Color(0xFF204366),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              flashcard.backText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
