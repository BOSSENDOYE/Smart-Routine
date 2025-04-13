import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test basique de construction', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Test')),
        ),
      ),
    );

    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);
  });
}
