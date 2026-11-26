import 'package:ctrlgo/core/location/geolocator_position_source.dart';
import 'package:ctrlgo/core/location/gpx.dart';
import 'package:ctrlgo/core/location/position_source.dart';
import 'package:ctrlgo/core/location/simulated_position_source.dart';
import 'package:ctrlgo/core/network/connectivity.dart';
import 'package:ctrlgo/core/time/clock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dependencies.g.dart';

// The app's time, location and network. Tests override these providers
// with fakes; logic never reaches for DateTime.now() or geolocator itself.

@Riverpod(keepAlive: true)
Clock clock(Ref ref) => const SystemClock();

/// The web demo has no GPS worth using, so it replays the demo drive.
@Riverpod(keepAlive: true)
PositionSource positionSource(Ref ref) => kIsWeb
    ? SimulatedPositionSource(
        () async => parseGpx(
          await rootBundle.loadString('assets/demo/bangsar_south_klcc.gpx'),
        ),
        clock: ref.watch(clockProvider),
      )
    : const GeolocatorPositionSource();

@Riverpod(keepAlive: true)
Connectivity connectivity(Ref ref) => const AlwaysOnline();
