import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exercise_tracker/ui/pages/history-screen.dart';

void main() {
  testWidgets('HistoryScreen should render properly', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HistoryScreen()));
    
    final titleFinder = find.text('History');
    expect(titleFinder, findsOneWidget);
    
    final listViewFinder = find.byType(ListView);
    expect(listViewFinder, findsOneWidget);
  });
}
