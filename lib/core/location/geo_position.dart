import 'package:freezed_annotation/freezed_annotation.dart';

part 'geo_position.freezed.dart';

/// One location fix. Named so it doesn't clash with geolocator's `Position`.
@freezed
abstract class GeoPosition with _$GeoPosition {
  const factory({
    required double lat,
    required double lng,
    required DateTime timestamp,

    /// Horizontal accuracy radius in metres.
    @Default(0) double accuracyM,

    /// Degrees clockwise from north; null when unknown.
    double? headingDeg,
    double? speedKmh,
  }) = _GeoPosition;
}
