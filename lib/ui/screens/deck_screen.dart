import 'package:flashcard/models/deck.dart';
import 'package:flashcard/ui/screens/card_screen.dart';
import 'package:flashcard/ui/widgets/add_button.dart';
import 'package:flashcard/ui/widgets/deck_card.dart';
import 'package:flashcard/ui/widgets/deck_form.dart';
import 'package:flutter/material.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({super.key, required this.decks});
  final List<Deck> decks;

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  void onCreate(BuildContext context) async {
    Deck? newDeck = await showModalBottomSheet<Deck>(
      isScrollControlled: true,
      context: context,
      builder: (c) => DeckForm(),
    );
    if (newDeck != null) {
      setState(() {
        widget.decks.add(newDeck);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: widget.decks.length,
              itemBuilder: (context, index) {
                final deck = widget.decks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: DeckCard(
                    name: deck.name,
                    category: deck.category,
                    cardCount: deck.cards.length,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardScreen(deck: deck),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: AddButton("Create a deck", onTap: () => onCreate(context)),
          ),
        ),
      ],
    );
  }
}
