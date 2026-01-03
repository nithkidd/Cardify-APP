import 'package:flashcard/models/flashcard.dart';
import 'package:flutter/material.dart';

class FlashcardForm extends StatefulWidget {
  const FlashcardForm({super.key, this.deckId});
  final String? deckId;

  @override
  State<FlashcardForm> createState() => _FlashcardFormState();
}

class _FlashcardFormState extends State<FlashcardForm> {
  final frontText = TextEditingController();
  final backText = TextEditingController();

  @override
  void dispose() {
    frontText.dispose();
    backText.dispose();
    super.dispose();
  }

  void _onCreate() {
    final front = frontText.text;
    final back = backText.text;

    if (front.isEmpty || back.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter flashcard information.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final newFlashcard = Flashcard(
      null,
      widget.deckId!,
      front,
      back,
      0,
      DifficultyLevel.easy,
    );

    Navigator.pop<Flashcard>(context, newFlashcard);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Create a Flashcard',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF204366),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Flashcard Information',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: frontText,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              hintText: 'Front Text',
              hintStyle: TextStyle(color: Colors.grey[500]),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF204366)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: backText,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              hintText: 'Back Text',
              hintStyle: TextStyle(color: Colors.grey[500]),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF204366)),
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _onCreate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF204366),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Add', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
