import 'package:flashcard/data/database/database_helper.dart';
import 'package:flashcard/models/practice_session.dart';

class PracticeSessionRepositorySql {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // ============ ADD PRACTICE SESSION ============
  Future<void> addSession(PracticeSession session) async {
    final db = await _dbHelper.database;
    await db.insert('practice_sessions', _sessionToMap(session));
  }

  // ============ LOAD ALL SESSIONS ============
  Future<List<PracticeSession>> loadAll() async {
    final db = await _dbHelper.database;
    final sessionMaps = await db.query('practice_sessions');
    return sessionMaps.map((map) => _sessionFromMap(map)).toList();
  }

  // ============ LOAD BY ID ============
  Future<PracticeSession?> loadById(String sessionId) async {
    final db = await _dbHelper.database;
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
    final db = await _dbHelper.database;
    await db.delete(
      'practice_sessions',
      where: 'sessionId = ?',
      whereArgs: [sessionId],
    );
  }

  // ============ STATISTICS QUERIES ============

  // Get total number of sessions
  Future<int> getTotalSessions() async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM practice_sessions',
    );
    return result.first['count'] as int;
  }

  // Get count by session type
  Future<int> getSessionsByType(SessionType type) async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM practice_sessions WHERE sessionType = ?',
      [type.name],
    );
    return result.first['count'] as int;
  }

  // Get total cards reviewed
  Future<int> getTotalCardsReviewed() async {
    final db = await _dbHelper.database;
    final result = await db.rawQuery(
      'SELECT SUM(sessionSize) as total FROM practice_sessions',
    );
    return (result.first['total'] as int?) ?? 0;
  }

  // Get recent sessions (limit 10)
  Future<List<PracticeSession>> getRecentSessions({int limit = 10}) async {
    final db = await _dbHelper.database;
    final sessionMaps = await db.query('practice_sessions', limit: limit);
    return sessionMaps.map((map) => _sessionFromMap(map)).toList();
  }


  // ============ CONVERTERS ============
  Map<String, dynamic> _sessionToMap(PracticeSession session) {
    return {
      'sessionId': session.sessionId,
      'deckId': session.deckId,
      'title': session.title,
      'sessionSize': session.sessionSize,
      'sessionType': session.sessionType.name,
    };
  }

  PracticeSession _sessionFromMap(Map<String, dynamic> map) {
    return PracticeSession(
      map['sessionId'],
      map['title'] ?? '', // title (may be null if not joined)
      map['deckId'],
      map['sessionSize'],
      SessionType.values.firstWhere(
        (e) => e.name == map['sessionType'],
        orElse: () => SessionType.practice,
      ),
    );
  }
}
