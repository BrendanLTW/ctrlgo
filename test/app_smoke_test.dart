import 'package:ctrlgo/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app starts on Explore', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CtrlGoApp()));
    await tester.pumpAndSettle();

    // Placeholder title and the selected nav label.
    expect(find.text('Explore'), findsNWidgets(2));
  });
}
