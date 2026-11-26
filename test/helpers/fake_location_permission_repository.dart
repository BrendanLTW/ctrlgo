import 'package:ctrlgo/core/location/location_access.dart';

class FakeLocationPermissionRepository implements LocationPermissionRepository {
  new(this.access, {this.afterRequest = LocationAccess.whileUsing});

  /// What [check] returns; tests change it to mimic Settings.
  LocationAccess access;

  /// What the "system prompt" grants.
  LocationAccess afterRequest;

  int requests = 0;
  int settingsOpened = 0;

  @override
  Future<LocationAccess> check() async => access;

  @override
  Future<LocationAccess> request() async {
    requests++;
    return access = afterRequest;
  }

  @override
  Future<bool> openSettings() async {
    settingsOpened++;
    return true;
  }
}
