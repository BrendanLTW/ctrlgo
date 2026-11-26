import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/core/location/simulated_position_source.dart';
import 'package:ctrlgo/core/time/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

/// Reads fake_async's virtual time, so "now" moves as the test elapses.
class _FakeAsyncClock implements Clock {
  new(this._async, this._start);

  final FakeAsync _async;
  final DateTime _start;

  @override
  DateTime now() => _start.add(_async.elapsed);
}

final _recordedAt = DateTime.utc(2026, 11, 26, 9, 41);
final _demoNow = DateTime.utc(2026, 12);

/// 10 points with uneven gaps, as a real recording has.
const _gapsS = [0, 1, 1, 2, 1, 5, 1, 1, 3, 1];
final List<GeoPosition> _track = [
  for (final (i, _) in _gapsS.indexed)
    GeoPosition(
      lat: 3.11 + i * 0.001,
      lng: 101.66 + i * 0.001,
      timestamp: _recordedAt.add(
        Duration(seconds: _gapsS.take(i + 1).fold(0, (a, b) => a + b)),
      ),
    ),
];

void main() {
  test('replays 10 points in order, each after its recorded gap', () {
    fakeAsync((async) {
      final source = SimulatedPositionSource.of(
        _track,
        clock: _FakeAsyncClock(async, _demoNow),
      );
      final got = <GeoPosition>[];
      source.positions.listen(got.add);

      async.flushMicrotasks();
      expect(got, hasLength(1), reason: 'first point is immediate');

      for (var i = 1; i < _track.length; i++) {
        final gap = Duration(seconds: _gapsS[i]);
        async.elapse(gap - const Duration(milliseconds: 1));
        expect(got, hasLength(i), reason: 'point $i not before its gap');
        async.elapse(const Duration(milliseconds: 1));
        expect(got, hasLength(i + 1), reason: 'point $i right at its gap');
      }

      expect(got.map((p) => (p.lat, p.lng)), _track.map((p) => (p.lat, p.lng)));
      // Stamped with the clock's time, not the recording's.
      expect(got.last.timestamp, _demoNow.add(const Duration(seconds: 16)));
    });
  });

  test('speed 2 replays twice as fast', () {
    fakeAsync((async) {
      final source = SimulatedPositionSource.of(
        _track,
        clock: _FakeAsyncClock(async, _demoNow),
        speed: 2,
      );
      final got = <GeoPosition>[];
      var done = false;
      source.positions.listen(got.add, onDone: () => done = true);

      async.elapse(const Duration(seconds: 8)); // 16 s recorded / 2
      expect(got, hasLength(10));
      expect(done, isTrue);
    });
  });
}
