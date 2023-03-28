import 'package:flutter_test/flutter_test.dart';
import 'package:exercise_tracker/ui/controllers/section_controller.dart';

void main() {
  test('getSetcions', () {
    // Arrange
    final sectionController = SectionController();

    // Act
    final result = sectionController.getActivities();

    // Assert
    expect(result, isInstanceOf<List>());
  });
}
