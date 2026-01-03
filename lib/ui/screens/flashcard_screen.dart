import 'package:flashcard/data/repository/deck_repository_sql.dart';
import 'package:flashcard/models/deck.dart';
import 'package:flashcard/ui/widgets/add_button.dart';
import 'package:flashcard/ui/widgets/flashcard/flashcard_form.dart';
import 'package:flashcard/ui/widgets/flashcard/flashcard_item.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/models/flashcard.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({
    super.key,
    required this.deck,
    required this.repository,
  });

  final Deck deck;
  final DeckRepositorySql repository;

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  void onCreateFlashcard(BuildContext context) async {
    Flashcard? newFlashcard = await showModalBottomSheet<Flashcard>(
      isScrollControlled: false,
      context: context,
      builder: (c) => FlashcardForm(deckId: widget.deck.deckId),
    );
    if (newFlashcard != null) {
      await widget.repository.addFlashcard(
        widget.deck.flashcards,
        newFlashcard,
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.deck.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF204366),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Expanded(
            child: widget.deck.flashcards.isEmpty
                ? const Center(
                    child: Text(
                      'No Flashcards yet',
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 350,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.5,
                        ),
                    padding: const EdgeInsets.all(16),
                    itemCount: widget.deck.flashcards.length,
                    itemBuilder: (context, index) {
                      final flashcard = widget.deck.flashcards[index];
                      return FlashcardItem(flashcard: flashcard);
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: AddButton(
                "Create a Flashcard",
                onTap: () => onCreateFlashcard(context),
                icon: Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
