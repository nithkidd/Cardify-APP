import 'package:flashcard/models/deck.dart';
import 'package:flashcard/models/practice_session.dart';
import 'package:flutter/material.dart';

class PracticeSessionScreen extends StatefulWidget {
  final Deck deck;
  final SessionType sessionType;

  const PracticeSessionScreen(
    {
    super.key,
    required  this.sessionType,
    required this.deck, 
  });

  @override
  State<PracticeSessionScreen> createState() => _PracticeSessionScreenState();
}

class _PracticeSessionScreenState extends State<PracticeSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Placeholder());
  }
}
