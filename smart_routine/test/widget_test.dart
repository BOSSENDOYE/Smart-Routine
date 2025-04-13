import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:smart_routine/main.dart';

void main() {
  testWidgets('Task management widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the initial task list is empty.
    expect(find.text('No tasks available'), findsOneWidget);

    // Navigate to the Add Task screen.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter task details.
    await tester.enterText(find.byKey(Key('taskTitle')), 'Test Task');
    await tester.enterText(find.byKey(Key('taskDescription')), 'This is a test task.');
    await tester.tap(find.byKey(Key('saveButton')));
    await tester.pumpAndSettle();

    // Verify that the task has been added to the list.
    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('This is a test task.'), findsOneWidget);

    // Mark the task as completed.
    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    // Verify that the task is marked as completed.
    expect(find.byType(Checkbox), findsOneWidget);
  });
}