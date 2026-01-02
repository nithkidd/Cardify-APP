import 'package:uuid/uuid.dart';

enum SessionType { practice, special }

class PracticeSession {
  String sessionId;
  String deckId;

  int sessionSize;
  String startTime;
  String? endTime;

  SessionType sessionType;

  PracticeSession(
    String? sessionId,
    this.deckId,
    this.sessionSize,
    this.startTime,
    this.endTime,
    this.sessionType,
  ) : sessionId = sessionId ?? const Uuid().v4();
}
