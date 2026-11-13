import 'package:flutter_test/flutter_test.dart';
import 'package:l7m2/main.dart';

void main() {
  testWidgets('main screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());

    expect(find.text('Ты это прочитал!'), findsOneWidget);
  });
}
