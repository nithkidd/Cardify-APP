import 'package:flashcard/data/deck_mock.dart';
import 'package:flashcard/ui/screens/deck_screen.dart';
import 'package:flutter/material.dart';

class CardifyApp extends StatelessWidget {
  const CardifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 80,
          child: Image.asset(
            'lib/assets/cardify-logo.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        backgroundColor: const Color(0xFF204365),
      ),
      body: DeckScreen(decks: getMockDecks()),
      // backgroundColor: const Color(0xFF070706),
    );
  }
}
