import 'package:flutter_test/flutter_test.dart';
import 'package:theta_app/main.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ThetaApp());
    expect(find.text('Theta'), findsOneWidget);
  });
}
