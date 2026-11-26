import 'package:ctrlgo/app/app.dart';
import 'package:ctrlgo/app/dependencies.dart';
import 'package:ctrlgo/core/location/location_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_location_permission_repository.dart';

/// Pumps the whole app on a 390×844 phone with fake platform services.
/// Returns the permission fake so tests can drive and inspect it.
Future<FakeLocationPermissionRepository> pumpApp(
  WidgetTester tester, {
  LocationAccess access = LocationAccess.whileUsing,
  Brightness brightness = Brightness.light,
}) async {
  tester.view
    ..physicalSize = const Size(390, 844)
    ..devicePixelRatio = 1;
  tester.platformDispatcher.platformBrightnessTestValue = brightness;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

  final permissions = FakeLocationPermissionRepository(access);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        locationPermissionRepositoryProvider.overrideWithValue(permissions),
      ],
      child: const CtrlGoApp(),
    ),
  );
  await tester.pumpAndSettle();
  return permissions;
}
