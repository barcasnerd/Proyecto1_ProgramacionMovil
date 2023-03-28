import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exercise_tracker/ui/pages/section_creator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
void main() {
  testWidgets('test section creator widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SectionCreator(),
    ));

    await tester.tap(find.byType(GoogleMap));
    await tester.enterText(find.byType(TextFormField), 'My Section');
    await tester.pump();

    expect(find.text('My Section'), findsOneWidget);
  });
}
