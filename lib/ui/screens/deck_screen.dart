import 'package:flashcard/data/repository/deck_repository_sql.dart';
import 'package:flashcard/models/deck.dart';
import 'package:flashcard/ui/screens/flashcard_screen.dart';
import 'package:flashcard/ui/screens/statistics_screen.dart';
import 'package:flashcard/ui/widgets/button/add_button.dart';
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
      isLoading = false; //hey, the data is already loaded you can render now //OKOK
    });
  }

  void _showDeckForm([Deck? deck]) async {
    final result = await showModalBottomSheet<Deck>(
      isScrollControlled: false,
      context: context,
      builder: (c) => DeckForm(deck: deck),
    );

    if (result != null) {
      if (deck == null) {
        await repository.addDeck(result);
      } else {
        await repository.updateDeck(result);
      }
      await _loadDecks();
    }
  }

  void _onDelete(BuildContext context, Deck deck) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Deck'),
        content: Text(
          'Are you sure you want to delete "${deck.name}"? This will also delete all flashcards in this deck.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await repository.deleteDeck(deck.deckId);
      await _loadDecks();
    }
  }

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
      backgroundColor: Colors.grey[50],
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
                                  builder: (context) =>
                                      FlashcardScreen(deck: deck),
                                ),
                              );
                              await _loadDecks();
                            },
                            onEdit: () => _showDeckForm(deck),
                            onDelete: () => _onDelete(context, deck),
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
                onTap: _showDeckForm,
                icon: Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
