import 'package:ctrlgo/core/location/location_access.dart';
import 'package:ctrlgo/features/map/presentation/location_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('granted', () {
    for (final access in [LocationAccess.always, LocationAccess.whileUsing]) {
      testWidgets('${access.name}: the map shows with no sheet', (
        tester,
      ) async {
        await pumpApp(tester, access: access);

        expect(find.byType(GoogleMap), findsOneWidget);
        expect(find.byType(LocationSheet), findsNothing);
      });
    }
  });

  group('denied (LocDenied)', () {
    testWidgets('explains and offers Settings', (tester) async {
      await pumpApp(tester, access: LocationAccess.denied);

      expect(find.text('Location is turned off'), findsOneWidget);
      expect(find.text('Open Settings'), findsOneWidget);
      expect(find.text('Search without location'), findsOneWidget);
    });

    testWidgets('Open Settings opens the app settings page', (tester) async {
      final permissions = await pumpApp(tester, access: LocationAccess.denied);

      await tester.tap(find.text('Open Settings'));
      await tester.pump();

      expect(permissions.settingsOpened, 1);
    });

    testWidgets('coming back from Settings with access hides the sheet', (
      tester,
    ) async {
      final permissions = await pumpApp(tester, access: LocationAccess.denied);

      permissions.access = LocationAccess.whileUsing;
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();

      expect(find.byType(LocationSheet), findsNothing);
    });

    testWidgets('Search without location reveals the map', (tester) async {
      await pumpApp(tester, access: LocationAccess.denied);

      await tester.tap(find.text('Search without location'));
      await tester.pumpAndSettle();

      expect(find.byType(LocationSheet), findsNothing);
    });

    // Widget tests run as Android unless a variant says otherwise.
    testWidgets('names the Android settings path on Android', (tester) async {
      await pumpApp(tester, access: LocationAccess.denied);

      expect(
        find.textContaining(
          'Allow only while using the app',
          findRichText: true,
        ),
        findsOneWidget,
      );
    });

    testWidgets(
      'names the iOS settings path on iOS',
      variant: TargetPlatformVariant.only(TargetPlatform.iOS),
      (tester) async {
        await pumpApp(tester, access: LocationAccess.denied);

        expect(
          find.textContaining('While Using the App', findRichText: true),
          findsOneWidget,
        );
      },
    );

    testWidgets('renders in dark mode', (tester) async {
      await pumpApp(
        tester,
        access: LocationAccess.denied,
        brightness: Brightness.dark,
      );

      expect(tester.takeException(), isNull);
      expect(find.text('Location is turned off'), findsOneWidget);
    });
  });

  group('not asked yet', () {
    testWidgets('explains first, then asks the system', (tester) async {
      final permissions = await pumpApp(
        tester,
        access: LocationAccess.notAsked,
      );

      expect(find.text('See where you are'), findsOneWidget);
      expect(permissions.requests, 0, reason: 'no prompt before explaining');

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(permissions.requests, 1);
      expect(find.byType(LocationSheet), findsNothing);
    });

    testWidgets('a refusal at the prompt leads to LocDenied', (tester) async {
      final permissions = await pumpApp(tester, access: LocationAccess.notAsked)
        ..afterRequest = LocationAccess.denied;

      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();

      expect(permissions.requests, 1);
      expect(find.text('Location is turned off'), findsOneWidget);
    });
  });
}
