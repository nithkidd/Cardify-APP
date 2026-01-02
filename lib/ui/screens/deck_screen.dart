import 'package:flashcard/data/repository/deck_repository.dart';
import 'package:flashcard/models/deck.dart';
import 'package:flashcard/ui/screens/flashcard_screen.dart';
import 'package:flashcard/ui/widgets/add_button.dart';
import 'package:flashcard/ui/widgets/deck/deck_form.dart';
import 'package:flashcard/ui/widgets/deck/deck_item.dart';
import 'package:flutter/material.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({super.key});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  final DeckRepository _deckRepository = DeckRepository();
  List<Deck> decks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDecks();
  }

  Future<void> _loadDecks() async {
    final loadedDecks = await _deckRepository.loadAll();
    setState(() {
      decks = loadedDecks;
      isLoading = false;
    });
  }

  void onCreate(BuildContext context) async {
    Deck? newDeck = await showModalBottomSheet<Deck>(
      isScrollControlled: false,
      context: context,
      builder: (c) => DeckForm(),
    );
    if (newDeck != null) {
      await _deckRepository.addDeck(decks, newDeck);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF070706),
        body: Center(child: CircularProgressIndicator(color: Colors.cyan)),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: decks.length,
              itemBuilder: (context, index) {
                final deck = decks[index];
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
                      await _deckRepository.saveAll(decks); 
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
            child: AddButton(
              "Create a Deck",
              onTap: () => onCreate(context),
              icon: Icons.add,
            ),
          ),
        ),
      ],
    );
  }
}
