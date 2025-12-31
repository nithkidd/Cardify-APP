import 'package:flutter/material.dart';
import 'package:flashcard/models/deck.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key, required this.deck});

  final Deck deck;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deck.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF070706),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF070706),
      body: deck.cards.isEmpty
          ? const Center(
              child: Text(
                'No cards yet',
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: deck.cards.length,
              itemBuilder: (context, index) {
                final card = deck.cards[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Front:',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        card.frontText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Back:',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        card.backText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
