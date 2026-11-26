import 'dart:io';

import 'package:ctrlgo/core/location/gpx.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses track points with their times', () {
    const gpx = '''
<gpx><trk><trkseg>
  <trkpt lat="3.1105" lon="101.6660"><ele>40</ele><time>2026-11-26T09:41:00Z</time></trkpt>
  <trkpt lat="-3.5" lon="-101.25">
    <time>2026-11-26T09:41:05Z</time>
  </trkpt>
</trkseg></trk></gpx>''';

    final points = parseGpx(gpx);

    expect(points, hasLength(2));
    expect((points[0].lat, points[0].lng), (3.1105, 101.6660));
    expect((points[1].lat, points[1].lng), (-3.5, -101.25));
    expect(points[1].timestamp, DateTime.utc(2026, 11, 26, 9, 41, 5));
  });

  test('the demo drive runs Bangsar South to KLCC in time order', () {
    final points = parseGpx(
      File('test_fixtures/bangsar_south_klcc.gpx').readAsStringSync(),
    );

    expect(points.length, greaterThanOrEqualTo(10));
    expect(points.first.lat, closeTo(3.111, 0.002)); // Bangsar South
    expect(points.last.lat, closeTo(3.158, 0.002)); // KLCC
    for (var i = 1; i < points.length; i++) {
      expect(points[i].timestamp.isAfter(points[i - 1].timestamp), isTrue);
    }
  });
}
