import 'package:flashcard/models/deck.dart';
import 'package:flutter/material.dart';

class DeckCard extends StatelessWidget {
  const DeckCard({
    super.key,
    required this.name,
    required this.category,
    required this.cardCount,
    this.description,
    this.onTap,
  });

  final String name;
  final String? description;
  final DeckCategory category;
  final int cardCount;
  final VoidCallback? onTap;

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
              name,
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
                category.name,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$cardCount Cards',
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
