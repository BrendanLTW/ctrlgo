import 'dart:ui' as ui;

import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/core/location/location_access.dart';
import 'package:ctrlgo/core/location/simulated_position_source.dart';
import 'package:ctrlgo/core/theme/go_colors.dart';
import 'package:ctrlgo/core/time/clock.dart';
import 'package:ctrlgo/features/map/presentation/location_puck.dart';
import 'package:ctrlgo/features/map/presentation/map_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../helpers/pump_app.dart';

final _t0 = DateTime.utc(2026, 11, 26, 9, 41);

/// Three fixes a second apart heading up Jalan Kerinchi; the last one has
/// a heading.
final List<GeoPosition> _drive = [
  GeoPosition(lat: 3.1105, lng: 101.6660, timestamp: _t0),
  GeoPosition(
    lat: 3.1110,
    lng: 101.6661,
    timestamp: _t0.add(const Duration(seconds: 1)),
  ),
  GeoPosition(
    lat: 3.1115,
    lng: 101.6662,
    timestamp: _t0.add(const Duration(seconds: 2)),
    headingDeg: 10,
  ),
];

LatLng _at(int i) => LatLng(_drive[i].lat, _drive[i].lng);

Marker? _puck(WidgetTester tester) => tester
    .widget<GoogleMap>(find.byType(GoogleMap))
    .markers
    .where((m) => m.markerId == const MarkerId('me'))
    .firstOrNull;

/// The last camera move, as JSON so updates compare by value.
Object? _lastCamera() => fakeMaps.cameraUpdates.lastOrNull?.toJson();
Object _camTo(int i) => CameraUpdate.newLatLng(_at(i)).toJson();

MapButton _recentreButton(WidgetTester tester) => tester.widget<MapButton>(
  find.byWidgetPredicate(
    (w) => w is MapButton && w.label == 'Centre on your location',
  ),
);

Future<void> _pumpDrive(WidgetTester tester) => pumpApp(
  tester,
  positions: SimulatedPositionSource.of(_drive, clock: const SystemClock()),
);

void main() {
  testWidgets('the puck follows the simulated position', (tester) async {
    await _pumpDrive(tester);

    for (var i = 0; i < _drive.length; i++) {
      if (i > 0) await tester.pump(const Duration(seconds: 1));
      expect(_puck(tester)?.position, _at(i), reason: 'fix $i');
      expect(_lastCamera(), _camTo(i), reason: 'camera follows fix $i');
    }
    expect(_puck(tester)!.rotation, 10, reason: 'cone turns to the heading');
    expect(_recentreButton(tester).active, isTrue);
  });

  testWidgets('touching the map stops following; recentre animates back', (
    tester,
  ) async {
    await _pumpDrive(tester);

    await tester.tapAt(const Offset(195, 420)); // open map, mid-screen
    await tester.pump();
    expect(_recentreButton(tester).active, isFalse);

    fakeMaps.cameraUpdates.clear();
    await tester.pump(const Duration(seconds: 1));
    expect(_puck(tester)?.position, _at(1), reason: 'puck still moves');
    expect(fakeMaps.cameraUpdates, isEmpty, reason: 'camera stays put');

    await tester.tap(find.byWidget(_recentreButton(tester)));
    await tester.pump();
    expect(_lastCamera(), _camTo(1), reason: 'recentre animates to you');
    expect(_recentreButton(tester).active, isTrue);

    await tester.pump(const Duration(seconds: 1));
    expect(_lastCamera(), _camTo(2), reason: 'and follows again');
  });

  testWidgets('no puck without location access', (tester) async {
    await pumpApp(
      tester,
      access: LocationAccess.denied,
      positions: SimulatedPositionSource.of(_drive, clock: const SystemClock()),
    );
    await tester.pump(const Duration(seconds: 3));

    expect(_puck(tester), isNull);
    expect(_recentreButton(tester).active, isFalse);
  });

  testWidgets('shows search and quick destinations', (tester) async {
    await pumpApp(tester);

    expect(find.text('Where to?'), findsOneWidget);
    expect(find.bySemanticsLabel('Voice search'), findsOneWidget);
    for (final chip in ['Home', 'Work', 'Saved']) {
      expect(find.widgetWithText(InkWell, chip), findsOneWidget);
    }
  });

  testWidgets('the Saved chip opens the Saved tab', (tester) async {
    await pumpApp(tester);

    await tester.tap(find.widgetWithText(InkWell, 'Saved'));
    await tester.pumpAndSettle();

    expect(find.byType(GoogleMap), findsNothing);
  });

  testWidgets('the layers button toggles traffic', (tester) async {
    await pumpApp(tester);
    bool traffic() =>
        tester.widget<GoogleMap>(find.byType(GoogleMap)).trafficEnabled;

    expect(traffic(), isFalse);
    await tester.tap(find.bySemanticsLabel('Show traffic'));
    await tester.pump();
    expect(traffic(), isTrue);
  });

  testWidgets('paints the puck bitmap at the screen pixel ratio', (
    tester,
  ) async {
    final png = await tester.runAsync(
      () => paintPuck(GoColors.light, heading: true, pixelRatio: 2),
    );
    final image = await tester.runAsync(() async {
      final codec = await ui.instantiateImageCodec(png!);
      return (await codec.getNextFrame()).image;
    });

    expect(image!.width, (puckSize * 2).round());
    expect(image.height, image.width);
  });
}
