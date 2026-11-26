import 'package:ctrlgo/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String? _mapStyle(WidgetTester tester) =>
    tester.widget<GoogleMap>(find.byType(GoogleMap)).style;

void main() {
  testWidgets('toggling the theme switches the map style', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CtrlGoApp()));
    await tester.pumpAndSettle();

    // Land colour from DESIGN §2.3 identifies each style.
    expect(_mapStyle(tester), contains('#EEF1F5'));

    await tester.tap(find.byTooltip('Toggle theme (debug)'));
    await tester.pumpAndSettle();
    expect(_mapStyle(tester), contains('#0F1623'));

    await tester.tap(find.byTooltip('Toggle theme (debug)'));
    await tester.pumpAndSettle();
    expect(_mapStyle(tester), contains('#EEF1F5'));
  });

  testWidgets('starts dark when the system is dark', (tester) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await tester.pumpWidget(const ProviderScope(child: CtrlGoApp()));
    await tester.pumpAndSettle();

    expect(_mapStyle(tester), contains('#0F1623'));
  });
}
