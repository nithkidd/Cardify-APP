import 'package:uuid/uuid.dart';

enum SessionType { practice, special }

class PracticeSession {
  String sessionId;
  String deckId;
  int sessionSize;
  SessionType sessionType;

  PracticeSession(
    String? sessionId,
    this.deckId,
    this.sessionSize,
    this.sessionType, 
  ) : sessionId = sessionId ?? const Uuid().v4();
}
