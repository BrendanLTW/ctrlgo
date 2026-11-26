import 'package:ctrlgo/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  testWidgets('app starts on Explore with the map', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CtrlGoApp()));
    await tester.pumpAndSettle();

    expect(find.text('Explore'), findsOneWidget); // selected nav label
    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
