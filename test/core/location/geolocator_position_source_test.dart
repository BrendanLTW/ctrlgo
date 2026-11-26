import 'package:ctrlgo/core/location/geolocator_position_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

Position _fix({
  double heading = 90,
  double headingAccuracy = 5,
  double speed = 10,
  double speedAccuracy = 1,
}) => Position(
  latitude: 3.11,
  longitude: 101.66,
  timestamp: DateTime.utc(2026, 11, 26),
  accuracy: 8,
  altitude: 40,
  altitudeAccuracy: 3,
  heading: heading,
  headingAccuracy: headingAccuracy,
  speed: speed,
  speedAccuracy: speedAccuracy,
);

void main() {
  test('converts m/s to km/h and keeps heading and accuracy', () {
    final p = fromGeolocator(_fix());

    expect(p.speedKmh, closeTo(36, 1e-9));
    expect(p.headingDeg, 90);
    expect(p.accuracyM, 8);
    expect((p.lat, p.lng), (3.11, 101.66));
  });

  test('unknown speed and heading become null', () {
    final p = fromGeolocator(
      _fix(heading: -1, speed: -1, speedAccuracy: 0, headingAccuracy: 0),
    );

    expect(p.speedKmh, isNull);
    expect(p.headingDeg, isNull);
  });
}
