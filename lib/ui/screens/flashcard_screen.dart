import 'package:flashcard/data/repository/flashcard_repository.dart';
import 'package:flashcard/models/deck.dart';
import 'package:flashcard/ui/widgets/button/add_button.dart';
import 'package:flashcard/ui/widgets/flashcard/flashcard_form.dart';
import 'package:flashcard/ui/widgets/flashcard/flashcard_item.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/models/flashcard.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key, required this.deck});

  final Deck deck;

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final FlashcardRepository flashcardRepository = FlashcardRepository();

  void _onCreate() async {
    final result = await showModalBottomSheet<Flashcard>(
      isScrollControlled: false,
      context: context,
      builder: (c) => FlashcardForm(deckId: widget.deck.deckId),
    );

    if (result != null) {
      await flashcardRepository.addFlashcard(result);
      setState(() {
        widget.deck.flashcards.add(result);
      });
    }
  }

  void _onEdit(Flashcard flashcard) async {
    final result = await showModalBottomSheet<Flashcard>(
      isScrollControlled: false,
      context: context,
      builder: (c) =>
          FlashcardForm(deckId: widget.deck.deckId, flashcard: flashcard),
    );
    if (result != null) {
      await flashcardRepository.updateFlashcard(result);
      final index = widget.deck.flashcards.indexWhere(
        (element) => element.flashcardId == flashcard.flashcardId,
      );
      if (index != -1) {
        widget.deck.flashcards[index] = result;
      }
      setState(() {});
    }
  }

  void _onDelete(Flashcard flashcard) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Flashcard'),
        content: const Text('Are you sure you want to delete this flashcard?'),
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
      await flashcardRepository.deleteFlashcard(flashcard.flashcardId);
      setState(() {
        widget.deck.flashcards.remove(flashcard);
      });
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
                      return FlashcardItem(
                        flashcard: flashcard,
                        onEdit: () => _onEdit(flashcard),
                        onDelete: () => _onDelete(flashcard),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: AddButton(
                "Create a Flashcard",
                onTap: _onCreate,
                icon: Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
