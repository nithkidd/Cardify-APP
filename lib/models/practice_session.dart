import 'package:uuid/uuid.dart';

enum SessionType { practice, special }

class PracticeSession {
  String sessionId;
  String title;
  String deckId;
  int sessionSize;
  SessionType sessionType;

  PracticeSession(
    String? sessionId,
    this.title,
    this.deckId,
    this.sessionSize,
    this.sessionType,
  ) : sessionId = sessionId ?? const Uuid().v4();

  // ============ MAPPERS ============
  /// Convert PracticeSession to Map for database storage
  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'deckId': deckId,
      'title': title,
      'sessionSize': sessionSize,
      'sessionType': sessionType.name,
    };
  }

  /// Create PracticeSession from database Map
  factory PracticeSession.fromMap(Map<String, dynamic> map) {
    return PracticeSession(
      map['sessionId'],
      map['title'] ?? '',
      map['deckId'],
      map['sessionSize'],
      SessionType.values.firstWhere(
        (e) => e.name == map['sessionType'],
        orElse: () => SessionType.practice,
      ),
    );
  }
}


