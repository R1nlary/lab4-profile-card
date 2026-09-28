// Widget tests for the Interactive Like & Follower Profile Card.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab4_profile_card/main.dart';

void main() {
  testWidgets('Follow button toggles between Follow and Following', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProfileCardApp());

    expect(find.text('Follow'), findsOneWidget);
    expect(find.text('Following'), findsNothing);

    await tester.tap(find.text('Follow'));
    await tester.pump();

    expect(find.text('Follow'), findsNothing);
    expect(find.text('Following'), findsOneWidget);
  });

  testWidgets('Like button increments and decrements the counter', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProfileCardApp());

    expect(find.text('128'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    expect(find.text('129'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(find.text('128'), findsOneWidget);
  });

  testWidgets('Dislike button increments and decrements the counter', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProfileCardApp());

    expect(find.text('3'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.thumb_down_outlined));
    await tester.pump();
    expect(find.text('4'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.thumb_down));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('Liking cancels an existing dislike, and vice versa', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProfileCardApp());

    // Dislike first.
    await tester.tap(find.byIcon(Icons.thumb_down_outlined));
    await tester.pump();
    expect(find.text('4'), findsOneWidget); // dislikes: 3 -> 4
    expect(find.text('128'), findsOneWidget); // likes unchanged

    // Now like -> the dislike should be cancelled automatically.
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    expect(find.text('129'), findsOneWidget); // likes: 128 -> 129
    expect(find.text('3'), findsOneWidget); // dislikes back to 3

    // Now dislike -> the like should be cancelled automatically.
    await tester.tap(find.byIcon(Icons.thumb_down_outlined));
    await tester.pump();
    expect(find.text('128'), findsOneWidget); // likes back to 128
    expect(find.text('4'), findsOneWidget); // dislikes: 3 -> 4
  });

  testWidgets('Reset restores the default Follow, like and dislike state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProfileCardApp());

    // Change the state first.
    await tester.tap(find.text('Follow'));
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(find.text('Following'), findsOneWidget);
    expect(find.text('129'), findsOneWidget);

    // Reset should bring everything back to the defaults.
    await tester.tap(find.text('Reset'));
    await tester.pump();

    expect(find.text('Follow'), findsOneWidget);
    expect(find.text('128'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
  });
}
