/// Whether the app can reach the network, injected so offline states can be
/// tested.
abstract interface class Connectivity {
  bool get isOnline;
  Stream<bool> get onlineChanges;
}

// shortcut: always online until offline handling needs a real check
// (NoRoute in 1.7, GpsLost in 6.3); then back this with connectivity_plus.
class AlwaysOnline implements Connectivity {
  const new();

  @override
  bool get isOnline => true;

  @override
  Stream<bool> get onlineChanges => const Stream.empty();
}
