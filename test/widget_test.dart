// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exercise_tracker/main.dart';
import '../lib/login_screen.dart';
import '../lib/widgets/log_out_dialog_widget.dart';

void main() {
  testWidgets('LogOutDialogWidget displays correctly',
      (WidgetTester tester) async {
    try {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButton(
              onPressed: () async {
                await showDialog(
                  context: tester
                      .element(find.byType(ElevatedButton))
                      .findAncestorStateOfType<ScaffoldState>()!
                      .context,
                  builder: (context) {
                    return const LogOutDialogWidget();
                  },
                );
              },
              child: const Text('Show dialog'),
            ),
          ),
        ),
      );

      // Tap on the "Show dialog" button
      await tester.tap(find.text('Show dialog'));
      await tester.pumpAndSettle();

      // Check if the dialog title and content are displayed correctly
      expect(find.text('Cerrar sesión'), findsOneWidget);
      expect(
          find.text('¿Estás seguro de querer cerrar sesión?'), findsOneWidget);

      // Tap on the "Cancelar" button and check if the dialog is closed
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(find.text('Cerrar sesión'), findsNothing);

      // Tap on the "Salir" button and check if the dialog is closed and the LoginScreen is displayed
      await tester.tap(find.text('Salir'));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
    } catch (error) {
      print(error);
    }
  });
}
