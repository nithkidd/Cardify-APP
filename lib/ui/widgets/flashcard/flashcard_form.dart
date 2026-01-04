import 'package:flashcard/models/flashcard.dart';
import 'package:flutter/material.dart';

class FlashcardForm extends StatefulWidget {
  const FlashcardForm({super.key, this.deckId, this.flashcard});
  final String? deckId;
  final Flashcard? flashcard;

  @override
  State<FlashcardForm> createState() => _FlashcardFormState();
}

class _FlashcardFormState extends State<FlashcardForm> {
  final _frontTextController = TextEditingController();
  final _backTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.flashcard != null) {
      _frontTextController.text = widget.flashcard!.frontText;
      _backTextController.text = widget.flashcard!.backText;
    }
  }

  @override
  void dispose() {
    _frontTextController.dispose();
    _backTextController.dispose();
    super.dispose();
  }

  void _onCreate() {
    final front = _frontTextController.text;
    final back = _backTextController.text;

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

    final flashcard = Flashcard(
      widget.flashcard?.flashcardId,
      widget.deckId!,
      front,
      back,
      widget.flashcard?.difficultyScore ?? 0,
      widget.flashcard?.difficultyLevel ?? DifficultyLevel.easy,
    );

    Navigator.pop<Flashcard>(context, flashcard);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              widget.flashcard != null
                  ? 'Edit a Flashcard'
                  : 'Create a Flashcard',
              style: const TextStyle(
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
            controller: _frontTextController,
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
            controller: _backTextController,
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
                child: Text(
                  widget.flashcard != null ? 'Save' : 'Add',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
