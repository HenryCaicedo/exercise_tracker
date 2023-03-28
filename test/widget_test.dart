import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/widgets/segment_list_widget.dart';
import '../lib/segment_screen.dart';

void main() {
  testWidgets('SegmentListWidget should show a list of segments',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SegmentListWidget()));

    // Revisar que se muestre la lista
    expect(find.byType(ListView), findsOneWidget);

    // Revisar que se muestren los segmentos
    expect(find.text('Segmento 1'), findsOneWidget);
    expect(find.text('Segmento 2'), findsOneWidget);
    expect(find.text('Segmento 3'), findsOneWidget);
    expect(find.text('Segmento 4'), findsOneWidget);
    expect(find.text('Segmento 5'), findsOneWidget);
    expect(find.text('Segmento 6'), findsOneWidget);
  });

  testWidgets(
      'SegmentListWidget should add a new segment when the FAB is tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SegmentListWidget()));

    // Tap the FAB to add a new segment
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // Enter segment information and submit
    await tester.enterText(find.byType(TextField).at(0), 'New Segment');
    await tester.enterText(find.byType(TextField).at(1), 'Swimming');
    await tester.enterText(find.byType(TextField).at(2), '3.7');
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    // Check that the new segment is shown
    expect(find.text('New Segment'), findsOneWidget);
    expect(find.text('Swimming: 3.7 km'), findsOneWidget);
  });

  testWidgets(
      'SegmentListWidget should navigate to SegmentScreen when a segment is tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SegmentListWidget()));

    // Tap the first segment in the list
    await tester.tap(find.text('Segmento 1'));
    await tester.pumpAndSettle();

    // Check that we're on the SegmentScreen
    expect(find.byType(SegmentScreen), findsOneWidget);
  });
}
