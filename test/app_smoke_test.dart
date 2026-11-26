import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'helpers/pump_app.dart';

void main() {
  testWidgets('app starts on Explore with the map', (tester) async {
    await pumpApp(tester);

    expect(find.text('Explore'), findsOneWidget); // selected nav label
    expect(find.byType(GoogleMap), findsOneWidget);
  });
}
