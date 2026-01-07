import 'package:flutter/material.dart';
import 'package:flashcard/data/repository/practice_repository.dart';
import 'package:flashcard/models/practice_session.dart';
import 'package:flashcard/ui/widgets/statistics/statistic_item.dart';
import 'package:flashcard/ui/widgets/statistics/recent_item.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final PracticeSessionRepository practiceSessionRepository =
      PracticeSessionRepository();

  List<PracticeSession> recentSessions = [];
  bool isLoading = true;
  int totalSessions = 0;
  int practiceSessions = 0;
  int specialSessions = 0;
  int totalCards = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final total = await practiceSessionRepository.getTotalSessions();
    final practice = await practiceSessionRepository.getSessionsByType(
      SessionType.practice,
    );
    final special = await practiceSessionRepository.getSessionsByType(
      SessionType.special,
    );
    final cards = await practiceSessionRepository.getTotalCardsReviewed();
    final recent = await practiceSessionRepository.getRecentSessions();

    setState(() {
      totalSessions = total;
      practiceSessions = practice;
      specialSessions = special;
      totalCards = cards;
      recentSessions = recent;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF204366),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[50],

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatisticItem(
              label: 'Total Practice Sessions',
              value: totalSessions.toString(),
              icon: Icons.auto_stories,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),

            StatisticItem(
              label: 'Practice Mode',
              value: practiceSessions.toString(),
              icon: Icons.school,
              color: Colors.green,
            ),
            const SizedBox(height: 20),

            StatisticItem(
              label: 'Special Mode',
              value: specialSessions.toString(),
              icon: Icons.star,
              color: Colors.orange,
            ),
            const SizedBox(height: 20),

            StatisticItem(
              label: 'Total Cards Reviewed',
              value: totalCards.toString(),
              icon: Icons.style,
              color: Colors.purple,
            ),

            const SizedBox(height: 30),
            const Divider(color: Colors.black12, thickness: 1),
            const SizedBox(height: 16),
            Text(
              'Recent Sessions (${recentSessions.length})',
              style: const TextStyle(
                color: Color(0xFF204366),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (recentSessions.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentSessions.length,
                itemBuilder: (context, index) {
                  return RecentItem(session: recentSessions[index]);
                },
              )
            else
              const SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'No practice sessions yet.\nStart practicing to see your stats!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black38, fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
