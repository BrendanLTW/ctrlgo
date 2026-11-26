import 'package:ctrlgo/app/app.dart';
import 'package:ctrlgo/app/dependencies.dart';
import 'package:ctrlgo/core/location/location_access.dart';
import 'package:ctrlgo/core/location/position_source.dart';
import 'package:ctrlgo/core/location/simulated_position_source.dart';
import 'package:ctrlgo/core/time/clock.dart';
import 'package:ctrlgo/features/map/presentation/location_puck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'fake_location_permission_repository.dart';
import 'fake_maps_platform.dart';
import 'fixtures.dart';

/// The fake installed by `flutter_test_config.dart`.
FakeMapsPlatform get fakeMaps =>
    GoogleMapsFlutterPlatform.instance as FakeMapsPlatform;

/// Pumps the whole app on a 390×844 phone with fake platform services.
/// Returns the permission fake so tests can drive and inspect it.
Future<FakeLocationPermissionRepository> pumpApp(
  WidgetTester tester, {
  LocationAccess access = LocationAccess.whileUsing,
  Brightness brightness = Brightness.light,
  PositionSource? positions,
  FixturePlaceSearchRepository? places,
}) async {
  tester.view
    ..physicalSize = const Size(390, 844)
    ..devicePixelRatio = 1;
  tester.platformDispatcher.platformBrightnessTestValue = brightness;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
  fakeMaps.cameraUpdates.clear();

  final permissions = FakeLocationPermissionRepository(access);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        locationPermissionRepositoryProvider.overrideWithValue(permissions),
        positionSourceProvider.overrideWithValue(
          positions ??
              SimulatedPositionSource.of(const [], clock: const SystemClock()),
        ),
        placeSearchRepositoryProvider.overrideWithValue(
          places ?? FixturePlaceSearchRepository(),
        ),
        // Painting the real puck needs real async; tests check it separately.
        puckIconsProvider.overrideWith(
          (ref) async => PuckIcons.all(BitmapDescriptor.defaultMarker),
        ),
      ],
      child: const CtrlGoApp(),
    ),
  );
  await tester.pumpAndSettle();
  return permissions;
}
