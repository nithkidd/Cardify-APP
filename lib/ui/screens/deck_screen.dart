import 'package:flashcard/models/deck.dart';
import 'package:flashcard/ui/screens/flashcard_screen.dart';
import 'package:flashcard/ui/widgets/add_button.dart';
import 'package:flashcard/ui/widgets/deck_form.dart';
import 'package:flashcard/ui/widgets/deck_item.dart';
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
      isScrollControlled: false,
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
                  child: DeckItem(
                    deck: deck,
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FlashcardScreen(deck: deck),
                        ),
                      );
                      setState(() {});
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
            child: AddButton("Create a Deck", onTap: () => onCreate(context), icon: Icons.add,),
          ),
        ),
      ],
    );
  }
}
