import 'dart:async';

import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/core/location/position_source.dart';
import 'package:ctrlgo/core/time/clock.dart';

/// Replays a track with its original timing: the web demo's drive, or a
/// recorded fixture in tests (the "recorded" source is this class fed
/// with a recorded track).
class SimulatedPositionSource implements PositionSource {
  /// `speed` > 1 replays faster. Emitted fixes are stamped with `clock`'s
  /// time, so ages and ETAs read as live.
  new(this._loadTrack, {required this._clock, this._speed = 1});

  /// For a track already in memory.
  new of(List<GeoPosition> track, {required Clock clock, double speed = 1})
    : this(() async => track, clock: clock, speed: speed);

  final Future<List<GeoPosition>> Function() _loadTrack;
  final Clock _clock;
  final double _speed;

  @override
  Stream<GeoPosition> get positions async* {
    final track = await _loadTrack();
    for (final (i, p) in track.indexed) {
      if (i > 0) {
        final gap = p.timestamp.difference(track[i - 1].timestamp);
        await Future<void>.delayed(gap * (1 / _speed));
      }
      yield p.copyWith(timestamp: _clock.now());
    }
  }
}
