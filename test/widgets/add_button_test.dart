import 'package:flashcard/ui/widgets/button/add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddButton Widget Tests', () {
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
}
