import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:exercise_tracker/ui/pages/sections.dart';
import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';

void main() {
  group('Sections Widget Test', () {
    late Widget testWidget;
    late NavController controllerNav;

    setUp(() {
      controllerNav = NavController();
      testWidget = GetMaterialApp(
        home: Sections(),
        navigatorKey: Get.key,
      );
    });

    testWidgets('Sections should have a History Text',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      expect(find.text('History'), findsOneWidget);
    });

    testWidgets('Sections should have a All Sections Text',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      expect(find.text('All Sections'), findsOneWidget);
    });

    testWidgets('Sections should have a ListView', (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Sections should have a CustomNavBar',
        (WidgetTester tester) async {
      await tester.pumpWidget(testWidget);
      expect(find.byType(CustomNavBar), findsOneWidget);
    });
  });
}
