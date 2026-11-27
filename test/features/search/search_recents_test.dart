import 'package:ctrlgo/core/time/clock.dart';
import 'package:ctrlgo/features/search/domain/recent_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_recent_search_repository.dart';
import '../../helpers/fixtures.dart';
import '../../helpers/pump_app.dart';

class _FixedClock implements Clock {
  @override
  DateTime now() => DateTime(2026, 11, 26, 9, 41);
}

Future<void> _openSearch(WidgetTester tester) async {
  await tester.tap(find.text('Where to?'));
  await tester.pumpAndSettle();
}

Future<void> _typeAndWait(WidgetTester tester, String query) async {
  await tester.enterText(find.byType(TextField), query);
  await tester.pump(const Duration(milliseconds: 250));
  await tester.pumpAndSettle();
}

void main() {
  group('recents', () {
    testWidgets('show before typing, newest first, with when', (tester) async {
      await pumpApp(
        tester,
        clock: _FixedClock(),
        recents: FakeRecentSearchRepository([
          RecentSearch.place(
            placeId: 'mv',
            label: 'Mid Valley Megamall',
            secondaryText: 'Lingkaran Syed Putra',
            searchedAt: DateTime(2026, 11, 25, 18),
          ),
          RecentSearch.query(
            query: 'nasi lemak',
            searchedAt: DateTime(2026, 11, 23, 12),
          ),
        ]),
      );
      await _openSearch(tester);

      expect(find.text('RECENT'), findsOneWidget);
      expect(find.text('Lingkaran Syed Putra · yesterday'), findsOneWidget);
      expect(find.text('Mon'), findsOneWidget);
      final mv = tester.getTopLeft(find.text('Mid Valley Megamall')).dy;
      final nasi = tester.getTopLeft(find.text('nasi lemak')).dy;
      expect(mv, lessThan(nasi));
    });

    testWidgets('Clear empties the list', (tester) async {
      final recents = FakeRecentSearchRepository([
        const RecentSearch.query(query: 'klcc'),
      ]);
      await pumpApp(tester, recents: recents);
      await _openSearch(tester);

      await tester.tap(find.bySemanticsLabel('Clear recent searches'));
      await tester.pumpAndSettle();

      expect(recents.items, isEmpty);
      expect(find.text('RECENT'), findsNothing);
    });

    testWidgets('picking a suggestion remembers the place', (tester) async {
      final recents = FakeRecentSearchRepository();
      await pumpApp(tester, recents: recents);
      await _openSearch(tester);
      await _typeAndWait(tester, 'klcc');

      await tester.tap(find.textContaining('Suria', findRichText: true));
      await tester.pump();

      expect(recents.items, [
        const RecentSearch.place(
          placeId: 'fixture-suria-klcc',
          label: 'Suria KLCC',
          secondaryText: 'Jalan Ampang, Kuala Lumpur City Centre, Kuala Lumpur',
        ),
      ]);
    });

    testWidgets('the search key remembers the phrase', (tester) async {
      final recents = FakeRecentSearchRepository();
      await pumpApp(tester, recents: recents);
      await _openSearch(tester);
      await _typeAndWait(tester, 'klcc');

      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(recents.items, [const RecentSearch.query(query: 'klcc')]);
    });

    testWidgets('tapping a recent phrase searches it again', (tester) async {
      final places = FixturePlaceSearchRepository();
      await pumpApp(
        tester,
        places: places,
        recents: FakeRecentSearchRepository([
          const RecentSearch.query(query: 'klcc'),
        ]),
      );
      await _openSearch(tester);

      await tester.tap(find.text('klcc'));
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pumpAndSettle();

      expect(places.calls.map((c) => c.input), ['klcc']);
      expect(find.text('SUGGESTIONS'), findsOneWidget);
    });
  });

  group('SearchEmpty', () {
    const query = 'Kedai Kopi Lai Foong Jln Tun HS';

    testWidgets('explains, offers shorter searches and a pin', (tester) async {
      await pumpApp(
        tester,
        places: FixturePlaceSearchRepository()..noMatches.add(query),
      );
      await _openSearch(tester);
      await _typeAndWait(tester, query);

      expect(find.text('No places match that'), findsOneWidget);
      expect(find.text('TRY'), findsOneWidget);
      for (final t in ['Kedai Kopi', 'Lai Foong', 'Jln Tun']) {
        expect(find.text(t), findsOneWidget);
      }
      expect(find.text('Drop a pin instead'), findsOneWidget);
    });

    testWidgets('a Try chip searches that instead', (tester) async {
      final places = FixturePlaceSearchRepository()..noMatches.add(query);
      await pumpApp(tester, places: places);
      await _openSearch(tester);
      await _typeAndWait(tester, query);

      await tester.tap(find.text('Lai Foong'));
      await tester.pump(const Duration(milliseconds: 250));
      await tester.pumpAndSettle();

      expect(places.calls.last.input, 'Lai Foong');
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        'Lai Foong',
      );
      expect(find.text('No places match that'), findsNothing);
    });

    testWidgets('renders in dark mode', (tester) async {
      await pumpApp(
        tester,
        brightness: Brightness.dark,
        places: FixturePlaceSearchRepository()..noMatches.add(query),
      );
      await _openSearch(tester);
      await _typeAndWait(tester, query);

      expect(tester.takeException(), isNull);
      expect(find.text('No places match that'), findsOneWidget);
    });
  });
}
