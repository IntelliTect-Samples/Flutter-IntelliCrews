import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intellicrews/camera.dart';
import 'package:intellicrews/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("turn on camera", (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(const MyApp());

    // Act
    final fabButton = find.byType(FloatingActionButton);
    expect(fabButton, findsOneWidget);
    await tester.tap(fabButton);
    await tester.pump();

    // Assert
    final camera = find.byType(Camera);
    expect(camera, findsOneWidget);
  });
}
