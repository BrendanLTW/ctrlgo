import 'package:ctrlgo/core/location/geo_position.dart';

/// Where location fixes come from: the device GPS, or a replayed track for
/// the web demo and tests. Logic depends on this, never on geolocator.
abstract interface class PositionSource {
  Stream<GeoPosition> get positions;
}
