import 'package:flutter_test/flutter_test.dart';
import 'package:visionme/main.dart'; // ganti visionme dengan nama project kamu

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('VisiOnMe'), findsOneWidget);
  });
}