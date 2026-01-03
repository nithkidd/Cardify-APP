import 'package:flutter/material.dart';
import 'package:flashcard/models/practice_session.dart';

class RecentItem extends StatelessWidget {
  final PracticeSession session;

  const RecentItem({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final isPractice = session.sessionType == SessionType.practice;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            isPractice ? Icons.school : Icons.star,
            color: isPractice ? Colors.green : Colors.orange,
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.deckName.isEmpty ? 'Unknown' : session.deckName,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${session.sessionSize} cards • ${isPractice ? 'Practice' : 'Special'} Mode',
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
