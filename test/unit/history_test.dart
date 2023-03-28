import 'package:flutter_test/flutter_test.dart';
import 'package:exercise_tracker/ui/controllers/history_controller.dart';
import "package:exercise_tracker/ui/pages/draft_page.dart";
import 'package:flutter/material.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import 'package:iconly/iconly.dart';
import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  test('getActivities should return a list of activities', () {
    // Arrange
    final historyController = HistoryController();

    // Act
    final result = historyController.getActivities();

    // Assert
    expect(result, isInstanceOf<List>());
  });

  test('Get Distances', () {
    // Arrange
    final historyController = HistoryController();

    // Act
    final result = historyController.getDistance();

    // Assert
    expect(result, isInstanceOf<List>());
  });
  test('Get Durations', () {
    // Arrange
    final historyController = HistoryController();

    // Act
    final result = historyController.getDuration();

    // Assert
    expect(result, isInstanceOf<List>());
  });

  test('Get Type', () {
    // Arrange
    final historyController = HistoryController();

    // Act
    final result = historyController.getType();

    // Assert
    expect(result, isInstanceOf<List>());
  });
}
