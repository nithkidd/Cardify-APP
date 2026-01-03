import 'package:flashcard/data/database/database_service.dart';
import 'package:flashcard/models/practice_session.dart';

class PracticeSessionRepositorySql {
  final DatabaseService _dbService = DatabaseService();

  // ============ ADD PRACTICE SESSION ============
  Future<void> addSession(PracticeSession session) async {
    final db = await _dbService.database;
    await db.insert('practice_sessions', _sessionToMap(session));
  }

  // ============ LOAD ALL SESSIONS ============
  Future<List<PracticeSession>> loadAll() async {
    final db = await _dbService.database;
    final sessionMaps = await db.query('practice_sessions', orderBy: 'startTime DESC');
    return sessionMaps.map((map) => _sessionFromMap(map)).toList();
  }

  // ============ LOAD BY ID ============
  Future<PracticeSession?> loadById(String sessionId) async {
    final db = await _dbService.database;
    final maps = await db.query(
      'practice_sessions',
      where: 'sessionId = ?',
      whereArgs: [sessionId],
    );
    if (maps.isEmpty) return null;
    return _sessionFromMap(maps.first);
  }

  // ============ DELETE SESSION ============
  Future<void> deleteSession(String sessionId) async {
    final db = await _dbService.database;
    await db.delete(
      'practice_sessions',
      where: 'sessionId = ?',
      whereArgs: [sessionId],
    );
  }

  // ============ CONVERTERS ============
  Map<String, dynamic> _sessionToMap(PracticeSession session) {
    return {
      'sessionId': session.sessionId,
      'deckId': session.deckId,
      'sessionSize': session.sessionSize,
      'sessionType': session.sessionType.name,
    };
  }

  PracticeSession _sessionFromMap(Map<String, dynamic> map) {
    return PracticeSession(
      map['sessionId'],
      map['deckId'],
      map['sessionSize'],
      SessionType.values.firstWhere(
        (e) => e.name == map['sessionType'],
        orElse: () => SessionType.practice,
      ),
    );
  }
}