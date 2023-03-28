import 'package:exercise_tracker/ui/pages/profile-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ProfileScreen displays user profile information',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ProfileScreen()));
    expect(find.text('Profile'), findsAtLeastNWidgets(1));
    expect(find.text('Stefani Wong'), findsAtLeastNWidgets(1));
    expect(find.byType(Image), findsAtLeastNWidgets(1));
    expect(find.text('Height'), findsAtLeastNWidgets(1));
    expect(find.text('180cm'), findsAtLeastNWidgets(1));
    expect(find.text('Weight'), findsAtLeastNWidgets(1));
    expect(find.text('65kg'), findsAtLeastNWidgets(1));
    expect(find.text('Age'), findsAtLeastNWidgets(1));
    expect(find.text('22yo'), findsAtLeastNWidgets(1));
    expect(find.text('Avg. running speed'), findsAtLeastNWidgets(1));
    expect(find.text('18Km/h'), findsAtLeastNWidgets(1));
    expect(find.text('Avg. riding speed'), findsAtLeastNWidgets(1));
    expect(find.text('28Km/h'), findsAtLeastNWidgets(1));
    expect(find.text('Max running speed'), findsAtLeastNWidgets(1));
    expect(find.text('18Km/h'), findsAtLeastNWidgets(1));
    expect(find.text('Max riding speed'), findsAtLeastNWidgets(1));
    expect(find.text('42Km/h'), findsAtLeastNWidgets(1));
    expect(find.text('Avg. running time'), findsAtLeastNWidgets(1));
    expect(find.text('1.2 Hours'), findsAtLeastNWidgets(1));
    expect(find.text('Avg. riding time'), findsAtLeastNWidgets(1));
    expect(find.text('3.7 Hours'), findsAtLeastNWidgets(1));
    expect(find.text('Edit'), findsAtLeastNWidgets(1));
    expect(find.text('Delete Account'), findsAtLeastNWidgets(1));
  });
}
