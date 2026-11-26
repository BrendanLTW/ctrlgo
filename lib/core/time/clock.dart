/// The current time, injected so time-based logic (ETAs, expiry, stale
/// labels) can be tested with a fixed or advancing clock.
abstract interface class Clock {
  DateTime now();
}

class SystemClock implements Clock {
  const new();

  @override
  DateTime now() => DateTime.now();
}
