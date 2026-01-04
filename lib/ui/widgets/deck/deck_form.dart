import 'package:flashcard/models/deck.dart';
import 'package:flutter/material.dart';

class DeckForm extends StatefulWidget {
  const DeckForm({super.key, this.deck});

  final Deck? deck;

  @override
  State<DeckForm> createState() => _DeckFormState();
}

class _DeckFormState extends State<DeckForm> {
  final _nameController = TextEditingController();
  DeckCategory _selectedCategory = DeckCategory.general;


  @override
  void initState() {
    super.initState();
    if (widget.deck != null) {
      _nameController.text = widget.deck!.name;
      _selectedCategory = widget.deck!.category;
    }
  }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _onCreate() {
    final name = _nameController.text;

    if (name.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter a deck name.'),
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

    final newDeck = Deck(widget.deck?.deckId, name, _selectedCategory);

    Navigator.pop<Deck>(context, newDeck);
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
          Center(
            child: Text(
              widget.deck == null ? 'Create a Deck' : 'Edit Deck',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF204366),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Deck Information',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              hintText: 'Name',
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
          const Text(
            'Categories',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<DeckCategory>(
            initialValue: _selectedCategory,
            dropdownColor: Colors.white,
            style: const TextStyle(color: Colors.black87),

            items: DeckCategory.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(
                  category.name[0].toUpperCase() + category.name.substring(1),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedCategory = value;
                });
              }
            },
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
                  widget.deck == null ? 'Add' : 'Save',
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
