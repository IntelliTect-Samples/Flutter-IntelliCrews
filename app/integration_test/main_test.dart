// integration_test/main_test.dart
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intellicrews/main.dart';

import 'test_utils.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("turn on camera", (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(const MyApp());

    // Act
    final fabButton = find.byType(FloatingActionButton);
    expect(fabButton, findsOneWidget);
    await tester.tap(fabButton);
    await tester.pumpAndSettle();

    // Give the camera time to load
    await tester.pumpFor(duration: const Duration(seconds: 5));

    // Assert
    final camera = find.byType(CameraPreview);
    await tester.pumpUntilFound(camera);
  });
}
