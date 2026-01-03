import 'package:flashcard/data/repository/deck_repository_sql.dart';
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
  final DeckRepositorySql repository = DeckRepositorySql();
  List<Deck> decks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDecks();
  }

  Future<void> _loadDecks() async {
    final loadedDecks = await repository.loadAll();
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
      await repository.addDeck(decks, newDeck);
      setState(() {});
    }
  }

  // void onRemoveDeck(Deck deck) async {
  //   int deckIndex = decks.indexOf(deck);
    
  //   await repository.deleteDeck(deck.deckId);
  //   setState(() {
  //     decks.remove(deck);
  //   });

  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Deck deleted'),
  //       duration: Duration(seconds: 3),
  //       action: SnackBarAction(
  //         label: 'Undo',
  //         onPressed: () async {
  //           await repository.addDeck(decks, deck);
  //           setState(() {
  //             decks.insert(deckIndex, deck);
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF070706),
        body: Center(child: CircularProgressIndicator(color: Color(0xFF204366))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 80,
          child: Image.asset(
            'lib/assets/cardify-logo.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        backgroundColor: const Color(0xFF204366),
      ),
      body: Column(
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
                            builder: (context) => FlashcardScreen(
                              deck: deck,
                              repository: repository,
                            ),
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
              child: AddButton(
                "Create a Deck",
                onTap: () => onCreate(context),
                icon: Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
