import 'package:flashcard/data/deck_mock.dart';
import 'package:flashcard/ui/screens/deck_screen.dart';
import 'package:flutter/material.dart';

class CardifyApp extends StatelessWidget {
  const CardifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cardify App", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF070706),
      ),
      body: DeckScreen(decks: getMockDecks()),
      backgroundColor: const Color(0xFF070706),
    );
  }
}
