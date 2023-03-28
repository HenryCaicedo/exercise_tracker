import 'dart:html';

import 'package:exercise_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

Future<Widget> createHomeScreen() async {
  WidgetsFlutterBinding.ensureInitialized();
  return MyApp();
}

void main() {
  group('Integration test', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("inicio y creacion", (tester) async {
      Widget w = await createHomeScreen();
      await tester.pumpWidget(w);
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.widgetWithText(TextButton, 'Crear cuenta'));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.widgetWithText(ElevatedButton, 'Create'));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.widgetWithText(ElevatedButton, 'Iniciar'));
      await tester.pumpAndSettle(Duration(seconds: 5));

      // await tester.tap(find.widgetWithIcon(IconButton, Icons.logout));
      // await tester.pumpAndSettle(Duration(seconds: 5));

      // await tester.tap(find.widgetWithText(TextButton, 'Salir'));
      // await tester.pumpAndSettle(Duration(seconds: 5));
    });
    testWidgets("Actividades y detalle", (tester) async {
      Widget w = await createHomeScreen();
      await tester.pumpWidget(w);
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.widgetWithText(ElevatedButton, 'Iniciar'));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.text('Actividades'));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byType(ListView));
      await tester.pumpAndSettle(Duration(seconds: 5));
    });
    testWidgets("Segmentos", (tester) async {
      Widget w = await createHomeScreen();
      await tester.pumpWidget(w);
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.widgetWithText(ElevatedButton, 'Iniciar'));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.text('Segmentos'));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.widgetWithIcon(FloatingActionButton, Icons.add));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.widgetWithText(ElevatedButton, 'Crear'));
      await tester.pumpAndSettle(Duration(seconds: 2));

      await tester.tap(find.byType(ListView));
      await tester.pumpAndSettle(Duration(seconds: 5));
    });
  });
}
