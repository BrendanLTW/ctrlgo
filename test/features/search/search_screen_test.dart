import 'package:ctrlgo/core/location/location_access.dart';
import 'package:ctrlgo/core/theme/ct_tones.dart';
import 'package:ctrlgo/features/search/presentation/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';

/// The highlighted runs inside the row titled [title].
List<String> _highlighted(WidgetTester tester, String title) {
  final rich = tester
      .widgetList<RichText>(find.byType(RichText))
      .map((r) => r.text)
      .whereType<TextSpan>()
      .firstWhere((t) => t.toPlainText() == title);
  final out = <String>[];
  rich.visitChildren((span) {
    if (span is TextSpan && span.style?.backgroundColor != null) {
      out.add(span.text!);
    }
    return true;
  });
  return out;
}

Future<void> _openSearch(WidgetTester tester) async {
  await tester.tap(find.text('Where to?'));
  await tester.pumpAndSettle();
}

Future<void> _typeAndWait(WidgetTester tester, String query) async {
  await tester.enterText(find.byType(TextField), query);
  await tester.pump(const Duration(milliseconds: 250)); // debounce
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('shows highlighted results from the fixture', (tester) async {
    await pumpApp(tester);
    await _openSearch(tester);
    expect(find.byType(SearchScreen), findsOneWidget);

    await _typeAndWait(tester, 'klcc');

    expect(find.text('SUGGESTIONS'), findsOneWidget);
    expect(_highlighted(tester, 'Suria KLCC'), ['KLCC']);
    expect(_highlighted(tester, 'KLCC Park'), ['KLCC']);
    expect(_highlighted(tester, 'KLCC LRT Station'), ['KLCC']);
    expect(find.textContaining('Shopping mall · Jalan Ampang'), findsOneWidget);
    expect(find.text('6.8 km'), findsOneWidget);
    expect(find.textContaining('klcc restaurants'), findsNothing);
  });

  testWidgets('the highlight uses the yellow tone', (tester) async {
    await pumpApp(tester);
    await _openSearch(tester);
    await _typeAndWait(tester, 'klcc');

    final context = tester.element(find.byType(SearchScreen));
    final title = tester
        .widgetList<RichText>(find.byType(RichText))
        .map((r) => r.text as TextSpan)
        .firstWhere((t) => t.toPlainText() == 'Suria KLCC');
    Color? mark;
    title.visitChildren((span) {
      if (span is TextSpan && span.text == 'KLCC') {
        mark = span.style?.backgroundColor;
      }
      return true;
    });
    expect(mark, context.tones.yellow.tile);
  });

  testWidgets('one session token across keystrokes', (tester) async {
    final places = FixturePlaceSearchRepository();
    await pumpApp(tester, places: places);
    await _openSearch(tester);

    await _typeAndWait(tester, 'kl');
    await _typeAndWait(tester, 'klcc');

    expect(places.calls.map((c) => c.input), ['kl', 'klcc']);
    expect(places.calls.map((c) => c.sessionToken).toSet(), hasLength(1));
  });

  testWidgets('a failure offers Try again', (tester) async {
    final places = FixturePlaceSearchRepository()
      ..failWith = Exception('offline');
    await pumpApp(tester, places: places);
    await _openSearch(tester);
    await _typeAndWait(tester, 'klcc');

    expect(find.textContaining("Couldn't load suggestions"), findsOneWidget);
    places.failWith = null;
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    expect(_highlighted(tester, 'Suria KLCC'), ['KLCC']);
  });

  testWidgets('clear empties the field and the list', (tester) async {
    await pumpApp(tester);
    await _openSearch(tester);
    await _typeAndWait(tester, 'klcc');

    await tester.tap(find.bySemanticsLabel('Clear search'));
    await tester.pumpAndSettle();

    expect(find.text('SUGGESTIONS'), findsNothing);
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      isEmpty,
    );
  });

  testWidgets('Cancel goes back to the map', (tester) async {
    await pumpApp(tester);
    await _openSearch(tester);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.byType(SearchScreen), findsNothing);
    expect(find.byType(GoogleMap), findsOneWidget);
  });

  testWidgets('Search without location opens Search', (tester) async {
    await pumpApp(tester, access: LocationAccess.denied);

    await tester.tap(find.text('Search without location'));
    await tester.pumpAndSettle();

    expect(find.byType(SearchScreen), findsOneWidget);
  });

  testWidgets('renders in dark mode', (tester) async {
    await pumpApp(tester, brightness: Brightness.dark);
    await _openSearch(tester);
    await _typeAndWait(tester, 'klcc');

    expect(tester.takeException(), isNull);
    expect(_highlighted(tester, 'Suria KLCC'), ['KLCC']);
  });
}
