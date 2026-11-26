import 'package:ctrlgo/app/env.dart';
import 'package:ctrlgo/core/location/geolocator_permission_repository.dart';
import 'package:ctrlgo/core/location/geolocator_position_source.dart';
import 'package:ctrlgo/core/location/location_access.dart';
import 'package:ctrlgo/core/location/position_source.dart';
import 'package:ctrlgo/core/network/connectivity.dart';
import 'package:ctrlgo/core/time/clock.dart';
import 'package:ctrlgo/features/search/data/google_places_repository.dart';
import 'package:ctrlgo/features/search/domain/place_search_repository.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'dependencies.g.dart';

// The app's time, location and network. Tests override these providers
// with fakes (e.g. SimulatedPositionSource replaying a recorded drive);
// logic never reaches for DateTime.now() or geolocator itself.

@Riverpod(keepAlive: true)
Clock clock(Ref ref) => const SystemClock();

@Riverpod(keepAlive: true)
PositionSource positionSource(Ref ref) => const GeolocatorPositionSource();

@Riverpod(keepAlive: true)
Connectivity connectivity(Ref ref) => const AlwaysOnline();

/// Loaded once in `main` before the app starts, so reads are synchronous.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('Override in main (or a test).');

@Riverpod(keepAlive: true)
LocationPermissionRepository locationPermissionRepository(Ref ref) =>
    GeolocatorPermissionRepository(ref.watch(sharedPreferencesProvider));

@Riverpod(keepAlive: true)
Dio dio(Ref ref) => Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);

@Riverpod(keepAlive: true)
PlaceSearchRepository placeSearchRepository(Ref ref) => GooglePlacesRepository(
  ref.watch(dioProvider),
  apiKey: Env.mapsApiKey,
  appHeaders: Env.mapsAppHeaders,
);
