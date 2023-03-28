import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import 'package:iconly/iconly.dart';
import 'package:exercise_tracker/ui/controllers/nav_controller.dart';

void main() {
  group('CustomNavBar Widget Test', () {
    final navController = NavController();
    Widget _buildCustomNavBar() => MaterialApp(
          home: Scaffold(
            bottomNavigationBar: CustomNavBar(controller: navController),
          ),
        );

    testWidgets('should render BottomNavigationBar', (tester) async {
      await tester.pumpWidget(_buildCustomNavBar());
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('should render BottomNavigationBarItem with icon',
        (tester) async {
      await tester.pumpWidget(_buildCustomNavBar());
      expect(find.byIcon(IconlyLight.home), findsOneWidget);
      expect(find.byIcon(IconlyLight.activity), findsOneWidget);
      expect(find.byIcon(IconlyLight.profile), findsOneWidget);
    });
  });
}
