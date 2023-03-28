import 'package:exercise_tracker/ui/pages/history-screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exercise_tracker/ui/controllers/history_controller.dart';
import "package:exercise_tracker/ui/pages/draft_page.dart";
import 'package:flutter/material.dart';

void main() {
  testWidgets('ElevatedButtons is present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DraftScreen()));
    expect(find.byType(ElevatedButton), findsNWidgets(9));
  });

  testWidgets('HistoryScreen should display a list of activities',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HistoryScreen()));

    final listFinder = find.byType(ListView);

    expect(listFinder, findsOneWidget);
  });

  testWidgets('Containers', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HistoryScreen()));
    final listFinder = find.byType(Container);
    expect(listFinder, findsAtLeastNWidgets(7));
  });
  testWidgets('Texto', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HistoryScreen()));
    final listFinder = find.byType(Text);
    expect(listFinder, findsAtLeastNWidgets(7));
  });
  testWidgets('Textos', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HistoryScreen()));
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Latest Activity'), findsOneWidget);
    expect(find.text('View all activities'), findsOneWidget);
  });

  testWidgets('Rows', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: HistoryScreen(),
    )));
    final listFinder = find.byType(Text);
    expect(listFinder, findsWidgets);
  });
}
