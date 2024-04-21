import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:receptai/views/start/auth_view.dart';

void main() {
  testWidgets('AuthView UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: AuthView(),
    ));

    expect(find.text('ReceptAI'), findsOneWidget);

    expect(find.text('Prisijungimas'), findsOneWidget);
    expect(find.text('Registracija'), findsNothing);

    await tester.tap(find.text('Registruotis'));
    await tester.pump();

    expect(find.text('Prisijungimas'), findsNothing);
    expect(find.text('Registracija'), findsOneWidget);

    await tester.tap(find.text('Prisijungti'));
    await tester.pump();

    expect(find.text('Prisijungimas'), findsOneWidget);
    expect(find.text('Registracija'), findsNothing);
  });
}
