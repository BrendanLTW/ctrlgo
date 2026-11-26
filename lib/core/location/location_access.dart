/// What the app may do with the user's location (US-18).
enum LocationAccess {
  /// Never asked: show the explainer before the system prompt.
  notAsked,

  /// Refused, or the system won't ask again: show LocDenied.
  denied,

  /// Foreground only. Friends see "last seen" when the app is closed.
  whileUsing,

  /// Foreground and background.
  always;

  bool get granted => this == whileUsing || this == always;
}

abstract interface class LocationPermissionRepository {
  Future<LocationAccess> check();

  /// Shows the system prompt (once it has been explained) and returns the
  /// result.
  Future<LocationAccess> request();

  /// Opens this app's page in the system settings. False if it couldn't.
  Future<bool> openSettings();
}
