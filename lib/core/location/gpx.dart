import 'package:ctrlgo/core/location/geo_position.dart';

final _trkpt = RegExp(
  r'<trkpt\s+lat="([-\d.]+)"\s+lon="([-\d.]+)"\s*>.*?<time>([^<]+)</time>',
  dotAll: true,
);

/// Track points of a GPX file, in order.
// shortcut: a regex, not an XML parser; it reads only our own GPX files
// (lat before lon, one <time> each). Use package:xml if we take user files.
List<GeoPosition> parseGpx(String gpx) => [
  for (final m in _trkpt.allMatches(gpx))
    GeoPosition(
      lat: double.parse(m[1]!),
      lng: double.parse(m[2]!),
      timestamp: DateTime.parse(m[3]!),
    ),
];
