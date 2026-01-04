import 'package:flashcard/data/repository/flashcard_repository_sql.dart';
import 'package:flashcard/models/deck.dart';
import 'package:flashcard/models/flashcard.dart';
import 'package:flashcard/models/practice_session.dart';
import 'package:flashcard/ui/widgets/button/add_button.dart';
import 'package:flashcard/ui/widgets/deck/deck_form.dart';
import 'package:flashcard/ui/widgets/deck/deck_item.dart';
import 'package:flashcard/ui/widgets/flashcard/flashcard_form.dart';
import 'package:flashcard/ui/widgets/flashcard/flashcard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Model Tests', () {
    group('Deck Model', () {
      // 1. Test deck creation with auto-generated ID
      test('should create a deck with a generated ID when ID is null', () {
        final deck = Deck(null, 'Test Deck', DeckCategory.science);

        expect(deck.deckId, isNotEmpty);
        expect(deck.name, 'Test Deck');
        expect(deck.category, DeckCategory.science);
        expect(deck.flashcards, isEmpty);
      });

      // 2. Test deck creation with provided ID
      test('should create a deck with a provided ID', () {
        const testId = 'test-deck-123';
        final deck = Deck(testId, 'Test Deck', DeckCategory.history);

        expect(deck.deckId, testId);
        expect(deck.name, 'Test Deck');
        expect(deck.category, DeckCategory.history);
      });

      // 3. Test adding flashcards to deck
      test('should allow adding flashcards to deck', () {
        final deck = Deck(null, 'Test Deck', DeckCategory.math);
        final flashcard = Flashcard(
          null,
          deck.deckId,
          'Question',
          'Answer',
          0,
          DifficultyLevel.easy,
        );

        deck.flashcards.add(flashcard);

        expect(deck.flashcards.length, 1);
        expect(deck.flashcards.first.frontText, 'Question');
      });

      // 4. Test unique ID generation for decks
      test('should generate unique IDs for different decks', () {
        final deck1 = Deck(null, 'Deck 1', DeckCategory.science);
        final deck2 = Deck(null, 'Deck 2', DeckCategory.history);

        expect(deck1.deckId, isNot(equals(deck2.deckId)));
      });

      // 5. Test all deck categories are supported
      test('should support all deck categories', () {
        expect(DeckCategory.values.length, 5);
        expect(DeckCategory.values, contains(DeckCategory.science));
        expect(DeckCategory.values, contains(DeckCategory.history));
        expect(DeckCategory.values, contains(DeckCategory.math));
        expect(DeckCategory.values, contains(DeckCategory.geography));
        expect(DeckCategory.values, contains(DeckCategory.general));
      });
    });

    group('Flashcard Model', () {
      // 6. Test flashcard creation with auto-generated ID
      test('should create a flashcard with a generated ID when ID is null', () {
        final flashcard = Flashcard(
          null,
          'deck-123',
          'Front Text',
          'Back Text',
          0,
          DifficultyLevel.easy,
        );

        expect(flashcard.flashcardId, isNotEmpty);
        expect(flashcard.deckId, 'deck-123');
        expect(flashcard.frontText, 'Front Text');
        expect(flashcard.backText, 'Back Text');
        expect(flashcard.difficultyScore, 0);
        expect(flashcard.difficultyLevel, DifficultyLevel.easy);
      });

      // 7. Test flashcard creation with provided ID
      test('should create a flashcard with a provided ID', () {
        const testId = 'flashcard-456';
        final flashcard = Flashcard(
          testId,
          'deck-123',
          'Question',
          'Answer',
          3,
          DifficultyLevel.medium,
        );

        expect(flashcard.flashcardId, testId);
        expect(flashcard.difficultyScore, 3);
        expect(flashcard.difficultyLevel, DifficultyLevel.medium);
      });

      // 8. Test unique ID generation for flashcards
      test('should generate unique IDs for different flashcards', () {
        final flashcard1 = Flashcard(
          null,
          'deck-123',
          'Front 1',
          'Back 1',
          0,
          DifficultyLevel.easy,
        );
        final flashcard2 = Flashcard(
          null,
          'deck-123',
          'Front 2',
          'Back 2',
          0,
          DifficultyLevel.easy,
        );

        expect(flashcard1.flashcardId, isNot(equals(flashcard2.flashcardId)));
      });

      // 9. Test all difficulty levels are supported
      test('should support all difficulty levels', () {
        expect(DifficultyLevel.values.length, 3);
        expect(DifficultyLevel.values, contains(DifficultyLevel.easy));
        expect(DifficultyLevel.values, contains(DifficultyLevel.medium));
        expect(DifficultyLevel.values, contains(DifficultyLevel.hard));
      });

      // 10. Test difficulty level times multiplier values
      test('difficulty level should have correct times multiplier', () {
        expect(DifficultyLevel.easy.times, 1);
        expect(DifficultyLevel.medium.times, 3);
        expect(DifficultyLevel.hard.times, 5);
      });

      // 11. Test updating flashcard properties
      test('should allow updating flashcard properties', () {
        final flashcard = Flashcard(
          null,
          'deck-123',
          'Initial Front',
          'Initial Back',
          0,
          DifficultyLevel.easy,
        );

        flashcard.frontText = 'Updated Front';
        flashcard.backText = 'Updated Back';
        flashcard.difficultyScore = 5;
        flashcard.difficultyLevel = DifficultyLevel.hard;

        expect(flashcard.frontText, 'Updated Front');
        expect(flashcard.backText, 'Updated Back');
        expect(flashcard.difficultyScore, 5);
        expect(flashcard.difficultyLevel, DifficultyLevel.hard);
      });
    });

    group('PracticeSession Model', () {
      // 12. Test practice session creation with auto-generated ID
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

      // 13. Test practice session creation with provided ID
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

      // 14. Test unique ID generation for sessions
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

      // 15. Test both session types are supported
      test('should support both session types', () {
        expect(SessionType.values.length, 2);
        expect(SessionType.values, contains(SessionType.practice));
        expect(SessionType.values, contains(SessionType.special));
      });

      // 16. Test different session sizes
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
  });

  group('Widget Tests', () {
    group('DeckForm Widget', () {
      // 17. Test DeckForm create mode display
      testWidgets('should display create mode UI when no deck is provided', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: DeckForm())),
        );

        expect(find.text('Create a Deck'), findsOneWidget);
        expect(find.text('Add'), findsOneWidget);
      });

      // 18. Test DeckForm edit mode display
      testWidgets('should display edit mode UI when deck is provided', (
        WidgetTester tester,
      ) async {
        final testDeck = Deck('test-id', 'Test Deck', DeckCategory.science);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: DeckForm(deck: testDeck)),
          ),
        );

        expect(find.text('Edit Deck'), findsOneWidget);
        expect(find.text('Save'), findsOneWidget);
      });

      // 19. Test DeckForm pre-fills fields when editing
      testWidgets('should pre-fill form fields when editing deck', (
        WidgetTester tester,
      ) async {
        final testDeck = Deck('test-id', 'Existing Deck', DeckCategory.history);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: DeckForm(deck: testDeck)),
          ),
        );

        final textField = tester.widget<TextField>(find.byType(TextField));
        expect((textField.controller?.text), 'Existing Deck');
      });

      // 20. Test DeckForm shows cancel button
      testWidgets('should show cancel button', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: DeckForm())),
        );

        expect(find.text('Cancel'), findsOneWidget);
      });
    });

    group('FlashcardForm Widget', () {
      // 21. Test FlashcardForm create mode display
      testWidgets(
        'should display create mode UI when no flashcard is provided',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(body: FlashcardForm(deckId: 'deck-123')),
            ),
          );

          expect(find.text('Create a Flashcard'), findsOneWidget);
          expect(find.text('Add'), findsOneWidget);
        },
      );

      // 22. Test FlashcardForm edit mode display
      testWidgets('should display edit mode UI when flashcard is provided', (
        WidgetTester tester,
      ) async {
        final testFlashcard = Flashcard(
          'flashcard-123',
          'deck-123',
          'Front Text',
          'Back Text',
          0,
          DifficultyLevel.easy,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FlashcardForm(deckId: 'deck-123', flashcard: testFlashcard),
            ),
          ),
        );

        expect(find.text('Edit a Flashcard'), findsOneWidget);
        expect(find.text('Save'), findsOneWidget);
      });

      // 23. Test FlashcardForm pre-fills fields when editing
      testWidgets('should pre-fill form fields when editing flashcard', (
        WidgetTester tester,
      ) async {
        final testFlashcard = Flashcard(
          'flashcard-123',
          'deck-123',
          'Existing Front',
          'Existing Back',
          2,
          DifficultyLevel.medium,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FlashcardForm(deckId: 'deck-123', flashcard: testFlashcard),
            ),
          ),
        );

        final textFields = tester
            .widgetList<TextField>(find.byType(TextField))
            .toList();
        expect(textFields[0].controller?.text, 'Existing Front');
        expect(textFields[1].controller?.text, 'Existing Back');
      });

      // 24. Test FlashcardForm has required text fields
      testWidgets('should have front and back text fields', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: FlashcardForm(deckId: 'deck-123')),
          ),
        );

        expect(find.byType(TextField), findsNWidgets(2));
        expect(find.text('Front Text'), findsOneWidget);
        expect(find.text('Back Text'), findsOneWidget);
      });
      // 25. Test FlashcardForm shows cancel button
      testWidgets('should show cancel button', (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(body: FlashcardForm(deckId: 'deck-123')),
          ),
        );

        expect(find.text('Cancel'), findsOneWidget);
      });
    });

    group('AddButton Widget', () {
      // 26. Test AddButton displays text
      testWidgets('should display button text', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AddButton('Create New Item', onTap: () {}, icon: Icons.add),
            ),
          ),
        );

        expect(find.text('Create New Item'), findsOneWidget);
      });

      // 27. Test AddButton displays icon

      testWidgets('should display icon', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AddButton('Create', onTap: () {}, icon: Icons.add_circle),
            ),
          ),
        );

        expect(find.byIcon(Icons.add_circle), findsOneWidget);
      });

      // 28. Test AddButton calls onTap callback

      testWidgets('should call onTap when tapped', (WidgetTester tester) async {
        var tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AddButton(
                'Tap Me',
                onTap: () => tapped = true,
                icon: Icons.add,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(AddButton));
        await tester.pump();

        expect(tapped, isTrue);
      });

      // 29. Test AddButton is a TextButton

      testWidgets('should be a TextButton', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AddButton('Test', onTap: () {}, icon: Icons.add),
            ),
          ),
        );

        expect(find.byType(TextButton), findsOneWidget);
      });
    });

    group('DeckItem Widget', () {
      late Deck testDeck;

      setUp(() {
        testDeck = Deck('deck-123', 'Science Deck', DeckCategory.science);
        testDeck.flashcards = [
          Flashcard(null, 'deck-123', 'Q1', 'A1', 0, DifficultyLevel.easy),
          Flashcard(null, 'deck-123', 'Q2', 'A2', 0, DifficultyLevel.easy),
        ];
      });

      // 30. Test DeckItem displays deck name
      testWidgets('should display deck name', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DeckItem(deck: testDeck, onTap: () {}),
            ),
          ),
        );

        expect(find.text('Science Deck'), findsOneWidget);
      });

      // 31. Test DeckItem displays deck category

      testWidgets('should display deck category', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DeckItem(deck: testDeck, onTap: () {}),
            ),
          ),
        );

        expect(find.text('Science'), findsOneWidget);
      });

      // 32. Test DeckItem displays flashcard count

      testWidgets('should display flashcard count', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DeckItem(deck: testDeck, onTap: () {}),
            ),
          ),
        );

        expect(find.text('2 Cards'), findsOneWidget);
      });

      // 33. Test DeckItem calls onTap callback

      testWidgets('should call onTap when tapped', (WidgetTester tester) async {
        var tapped = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DeckItem(deck: testDeck, onTap: () => tapped = true),
            ),
          ),
        );

        await tester.tap(find.text('Science Deck'));
        await tester.pump();

        expect(tapped, isTrue);
      });

      // 34. Test DeckItem shows popup menu button

      testWidgets('should show popup menu button', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DeckItem(
                deck: testDeck,
                onTap: () {},
                onEdit: () {},
                onDelete: () {},
              ),
            ),
          ),
        );

        expect(find.byType(PopupMenuButton<String>), findsOneWidget);
      });

      // 35. Test DeckItem shows session buttons when deck has flashcards

      testWidgets('should show session buttons when deck has flashcards', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DeckItem(deck: testDeck, onTap: () {}),
            ),
          ),
        );

        expect(find.text('Practice Session'), findsOneWidget);
        expect(find.text('Special Session'), findsOneWidget);
      });

      // 36. Test DeckItem hides session buttons when deck is empty

      testWidgets('should not show session buttons when deck is empty', (
        WidgetTester tester,
      ) async {
        final emptyDeck = Deck('deck-456', 'Empty Deck', DeckCategory.math);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: DeckItem(deck: emptyDeck, onTap: () {}),
            ),
          ),
        );

        expect(find.text('Practice Session'), findsNothing);
        expect(find.text('Special Session'), findsNothing);
      });
    });

    group('FlashcardItem Widget', () {
      late Flashcard testFlashcard;

      setUp(() {
        testFlashcard = Flashcard(
          'flashcard-123',
          'deck-123',
          'What is 2+2?',
          '4',
          0,
          DifficultyLevel.easy,
        );
      });

      // 37. Test FlashcardItem displays front text label
      testWidgets('should display front text label', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: FlashcardItem(flashcard: testFlashcard)),
          ),
        );

        expect(find.text('Front:'), findsOneWidget);
      });

      // 38. Test FlashcardItem displays back text label

      testWidgets('should display back text label', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: FlashcardItem(flashcard: testFlashcard)),
          ),
        );

        expect(find.text('Back:'), findsOneWidget);
      });

      // 39. Test FlashcardItem displays front text

      testWidgets('should display front text', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: FlashcardItem(flashcard: testFlashcard)),
          ),
        );

        expect(find.text('What is 2+2?'), findsOneWidget);
      });

      // 40. Test FlashcardItem displays back text

      testWidgets('should display back text', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(body: FlashcardItem(flashcard: testFlashcard)),
          ),
        );

        expect(find.text('4'), findsOneWidget);
      });

      // 41. Test FlashcardItem shows popup menu when callbacks provided

      testWidgets('should show popup menu when callbacks are provided', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FlashcardItem(
                flashcard: testFlashcard,
                onEdit: () {},
                onDelete: () {},
              ),
            ),
          ),
        );

        expect(find.byType(PopupMenuButton<String>), findsOneWidget);
      });

      // 42. Test FlashcardItem calls onEdit callback
      testWidgets('should call onEdit when edit is selected', (
        WidgetTester tester,
      ) async {
        var editCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FlashcardItem(
                flashcard: testFlashcard,
                onEdit: () => editCalled = true,
                onDelete: () {},
              ),
            ),
          ),
        );

        await tester.tap(find.byType(PopupMenuButton<String>));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Edit'));
        await tester.pumpAndSettle();

        expect(editCalled, isTrue);
      });

      // 43. Test FlashcardItem calls onDelete callback
      testWidgets('should call onDelete when delete is selected', (
        WidgetTester tester,
      ) async {
        var deleteCalled = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FlashcardItem(
                flashcard: testFlashcard,
                onEdit: () {},
                onDelete: () => deleteCalled = true,
              ),
            ),
          ),
        );

        await tester.tap(find.byType(PopupMenuButton<String>));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Delete'));
        await tester.pumpAndSettle();

        expect(deleteCalled, isTrue);
      });
    });
  });

  group('Repository Tests', () {
    group('FlashcardRepositorySql', () {
      late FlashcardRepositorySql repository;

      setUp(() {
        repository = FlashcardRepositorySql();
      });

      group('Difficulty Calculation', () {
        // 44. Test difficulty calculation returns easy for low scores
        test('should return easy for score <= 2', () {
          expect(repository.calculateDifficultyLevel(0), DifficultyLevel.easy);
          expect(repository.calculateDifficultyLevel(1), DifficultyLevel.easy);
          expect(repository.calculateDifficultyLevel(2), DifficultyLevel.easy);
        });

        // 45. Test difficulty calculation returns medium for score 3

        test('should return medium for score 3', () {
          expect(
            repository.calculateDifficultyLevel(3),
            DifficultyLevel.medium,
          );
        });

        // 46. Test difficulty calculation returns hard for high scores

        test('should return hard for score > 3', () {
          expect(repository.calculateDifficultyLevel(4), DifficultyLevel.hard);
          expect(repository.calculateDifficultyLevel(5), DifficultyLevel.hard);
          expect(repository.calculateDifficultyLevel(10), DifficultyLevel.hard);
        });
      });

      group('Flashcard Enums', () {
        // 47. Test difficulty level enum names
        test('difficulty level enum should have correct values', () {
          expect(DifficultyLevel.easy.name, 'easy');
          expect(DifficultyLevel.medium.name, 'medium');
          expect(DifficultyLevel.hard.name, 'hard');
        });

        // 48. Test difficulty level times multiplier
        test('difficulty level times multiplier should be correct', () {
          expect(DifficultyLevel.easy.times, 1);
          expect(DifficultyLevel.medium.times, 3);
          expect(DifficultyLevel.hard.times, 5);
        });
      });
    });
  });
}
