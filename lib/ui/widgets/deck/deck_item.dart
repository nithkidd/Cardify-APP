import 'package:flashcard/models/deck.dart';
import 'package:flashcard/models/practice_session.dart';
import 'package:flashcard/ui/screens/practice_session_screen.dart';
import 'package:flashcard/ui/widgets/practice/practice_form.dart';
import 'package:flashcard/ui/widgets/button/session_button.dart';
import 'package:flutter/material.dart';

class DeckItem extends StatelessWidget {
  const DeckItem({
    super.key,
    required this.deck,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  final Deck deck;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  void startSession(BuildContext context, SessionType sessionType) async {
    if (sessionType == SessionType.special) {
      int? newDeckSize = await showModalBottomSheet<int>(
        isScrollControlled: false,
        context: context,
        builder: (c) => PracticeForm(deckSize: deck.flashcards.length),
      );
      if (newDeckSize == null) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PracticeSessionScreen(
            deck: deck,
            sessionType: sessionType,
            sessionSize: newDeckSize,
          ),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PracticeSessionScreen(deck: deck, sessionType: sessionType),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(51),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    deck.name,
                    style: const TextStyle(
                      color: Color(0xFF204366),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Color(0xFF204366)),
                  color: Colors.white,
                  onSelected: (value) {
                    if (value == 'edit' && onEdit != null) {
                      onEdit!();
                    } else if (value == 'delete' && onDelete != null) {
                      onDelete!();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Color(0xFF204366), size: 20),
                          SizedBox(width: 8),
                          Text('Edit', style: TextStyle(color: Colors.black87)),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF204366),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                deck.category.name[0].toUpperCase() + deck.category.name.substring(1),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${deck.flashcards.length} Cards',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            if (deck.flashcards.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  SessionButton(
                    "Practice Session",
                    onTap: () => startSession(context, SessionType.practice),
                  ),
                  const SizedBox(width: 8),
                  SessionButton(
                    "Special Session",
                    onTap: () => startSession(context, SessionType.special),
                    tooltipMessage:
                        "This stage the harder card will appear more",
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
