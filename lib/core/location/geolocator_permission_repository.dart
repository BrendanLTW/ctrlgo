import 'package:ctrlgo/core/location/location_access.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeolocatorPermissionRepository implements LocationPermissionRepository {
  new(this._prefs, {GeolocatorPlatform? platform})
    : _platform = platform ?? GeolocatorPlatform.instance;

  /// Geolocator reports "denied" both before the first prompt and after a
  /// refusal, so we remember whether we've asked.
  static const askedKey = 'location.asked';

  final SharedPreferences _prefs;
  final GeolocatorPlatform _platform;

  @override
  Future<LocationAccess> check() async =>
      _map(await _platform.checkPermission());

  @override
  Future<LocationAccess> request() async {
    await _prefs.setBool(askedKey, true);
    return _map(await _platform.requestPermission());
  }

  // On Android this opens the app's details page in Settings, where
  // Permissions › Location lives.
  @override
  Future<bool> openSettings() => _platform.openAppSettings();

  LocationAccess _map(LocationPermission p) => switch (p) {
    LocationPermission.always => LocationAccess.always,
    LocationPermission.whileInUse => LocationAccess.whileUsing,
    LocationPermission.denied when !(_prefs.getBool(askedKey) ?? false) =>
      LocationAccess.notAsked,
    LocationPermission.denied ||
    LocationPermission.deniedForever ||
    LocationPermission.unableToDetermine => LocationAccess.denied,
  };
}
