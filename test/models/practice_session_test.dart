import 'package:flashcard/models/practice_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PracticeSession Model Tests', () {
    test(
      'should create a practice session with generated ID when ID is null',
      () {
        final session = PracticeSession(
          null,
          'Test Deck',
          'deck-123',
          10,
          SessionType.practice,
        );

        expect(session.sessionId, isNotEmpty);
        expect(session.deckName, 'Test Deck');
        expect(session.deckId, 'deck-123');
        expect(session.sessionSize, 10);
        expect(session.sessionType, SessionType.practice);
      },
    );

    test('should create a practice session with provided ID', () {
      const testId = 'session-456';
      final session = PracticeSession(
        testId,
        'Test Deck',
        'deck-123',
        15,
        SessionType.special,
      );

      expect(session.sessionId, testId);
      expect(session.sessionSize, 15);
      expect(session.sessionType, SessionType.special);
    });

    test('should generate unique IDs for different sessions', () {
      final session1 = PracticeSession(
        null,
        'Deck 1',
        'deck-123',
        10,
        SessionType.practice,
      );
      final session2 = PracticeSession(
        null,
        'Deck 2',
        'deck-456',
        20,
        SessionType.special,
      );

      expect(session1.sessionId, isNot(equals(session2.sessionId)));
    });

    test('should support both session types', () {
      expect(SessionType.values.length, 2);
      expect(SessionType.values, contains(SessionType.practice));
      expect(SessionType.values, contains(SessionType.special));
    });

    test('should allow different session sizes', () {
      final session1 = PracticeSession(
        null,
        'Test Deck',
        'deck-123',
        5,
        SessionType.practice,
      );
      final session2 = PracticeSession(
        null,
        'Test Deck',
        'deck-123',
        100,
        SessionType.special,
      );

      expect(session1.sessionSize, 5);
      expect(session2.sessionSize, 100);
    });
  });
}
