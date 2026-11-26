import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/core/location/position_source.dart';
import 'package:geolocator/geolocator.dart';

/// The device's GPS via geolocator. Needs location permission (task 1.1);
/// without it the stream errors.
class GeolocatorPositionSource implements PositionSource {
  const new();

  @override
  Stream<GeoPosition> get positions => Geolocator.getPositionStream(
    // High accuracy, every fix: navigation wants 1 Hz (PRD §6).
    locationSettings: const LocationSettings(),
  ).map(fromGeolocator);
}

/// Geolocator reports speed in m/s and -1 or 0 for unknown values.
GeoPosition fromGeolocator(Position p) => GeoPosition(
  lat: p.latitude,
  lng: p.longitude,
  timestamp: p.timestamp,
  accuracyM: p.accuracy,
  headingDeg: p.heading >= 0 && p.headingAccuracy > 0 ? p.heading : null,
  speedKmh: p.speed >= 0 && p.speedAccuracy > 0 ? p.speed * 3.6 : null,
);
