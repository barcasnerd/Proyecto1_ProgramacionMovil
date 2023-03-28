import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:exercise_tracker/ui/pages/draft_page.dart";

void main() {
  testWidgets('DropdownButton is present', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DraftScreen()));
    expect(find.byType(ElevatedButton), findsNWidgets(9));
  });
}