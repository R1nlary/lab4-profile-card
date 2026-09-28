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

    expect(find.text('128 likes'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    expect(find.text('129 likes'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();
    expect(find.text('128 likes'), findsOneWidget);
  });

  testWidgets('Reset restores the default Follow and like state', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProfileCardApp());

    // Change the state first.
    await tester.tap(find.text('Follow'));
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    expect(find.text('Following'), findsOneWidget);
    expect(find.text('129 likes'), findsOneWidget);

    // Reset should bring everything back to the defaults.
    await tester.tap(find.text('Reset'));
    await tester.pump();

    expect(find.text('Follow'), findsOneWidget);
    expect(find.text('128 likes'), findsOneWidget);
  });
}
