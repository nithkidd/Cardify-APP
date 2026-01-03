import 'package:flashcard/data/repository/deck_repository_sql.dart';
import 'package:flashcard/models/deck.dart';
import 'package:flashcard/ui/screens/flashcard_screen.dart';
import 'package:flashcard/ui/screens/statistics_screen.dart';
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
  List<Deck> filteredDecks = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDecks();
    _searchController.addListener(_filterDecks);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterDecks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredDecks = decks;
      } else {
        filteredDecks = decks.where((deck) {
          return deck.name.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  Future<void> _loadDecks() async {
    final loadedDecks = await repository.loadAll();
    setState(() {
      decks = loadedDecks;
      filteredDecks = loadedDecks;
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
      setState((
      ) {});
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
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 80,
          child: Image.asset('assets/cardify-logo.png', fit: BoxFit.fitHeight),
        ),
        backgroundColor: const Color(0xFF204366),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart, color: Colors.white),
            tooltip: 'Statistics',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatisticsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFF070706),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar UI
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search decks...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: filteredDecks.isEmpty
                  ? Center(
                      child: Text(
                        _searchController.text.isEmpty
                            ? 'No decks available'
                            : 'No decks found',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredDecks.length,
                      itemBuilder: (context, index) {
                        final deck = filteredDecks[index];
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
