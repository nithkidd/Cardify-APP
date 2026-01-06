import 'package:flutter/material.dart';

class SpecialSessionForm extends StatefulWidget {
  final int deckSize;

  const SpecialSessionForm({super.key, required this.deckSize});

  @override
  State<SpecialSessionForm> createState() => _SpecialSessionFormState();
}

class _SpecialSessionFormState extends State<SpecialSessionForm> {
  late double selectedCards = minCards.toDouble();
  late int minCards = widget.deckSize.clamp(1, widget.deckSize);
  late int maxCards = widget.deckSize * 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 80,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.black),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: const Text(
                    'Special Session',
                    style: TextStyle(
                      color: Color(0xFF204366),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () =>
                        Navigator.pop(context, selectedCards.toInt()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF204366),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Ready',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          const Text(
            'Number of card in this Session',
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),

          const SizedBox(height: 20),

          Text(
            '${selectedCards.toInt()} cards',
            style: const TextStyle(
              color: Color(0xFF204366),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Slider(
            value: selectedCards,
            min: minCards.toDouble(),
            max: maxCards.toDouble(),
            activeColor: const Color(0xFF204366),
            onChanged: (value) => setState(() => selectedCards = value),
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
