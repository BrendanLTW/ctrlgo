import 'package:ctrlgo/core/location/geolocator_permission_repository.dart';
import 'package:ctrlgo/core/location/location_access.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeGeolocator extends GeolocatorPlatform {
  new(this.permission, {LocationPermission? afterRequest})
    : afterRequest = afterRequest ?? permission;

  LocationPermission permission;
  LocationPermission afterRequest;
  int settingsOpened = 0;

  @override
  Future<LocationPermission> checkPermission() async => permission;

  @override
  Future<LocationPermission> requestPermission() async =>
      permission = afterRequest;

  @override
  Future<bool> openAppSettings() async {
    settingsOpened++;
    return true;
  }
}

Future<GeolocatorPermissionRepository> _repo(
  _FakeGeolocator platform, {
  bool asked = false,
}) async {
  SharedPreferences.setMockInitialValues({
    if (asked) GeolocatorPermissionRepository.askedKey: true,
  });
  return GeolocatorPermissionRepository(
    await SharedPreferences.getInstance(),
    platform: platform,
  );
}

void main() {
  test('denied before we ever asked is notAsked', () async {
    final repo = await _repo(_FakeGeolocator(LocationPermission.denied));
    expect(await repo.check(), LocationAccess.notAsked);
  });

  test('denied after asking is denied', () async {
    final repo = await _repo(
      _FakeGeolocator(LocationPermission.denied),
      asked: true,
    );
    expect(await repo.check(), LocationAccess.denied);
  });

  for (final (platform, expected) in [
    (LocationPermission.always, LocationAccess.always),
    (LocationPermission.whileInUse, LocationAccess.whileUsing),
    (LocationPermission.deniedForever, LocationAccess.denied),
    (LocationPermission.unableToDetermine, LocationAccess.denied),
  ]) {
    test('${platform.name} maps to ${expected.name}', () async {
      final repo = await _repo(_FakeGeolocator(platform));
      expect(await repo.check(), expected);
    });
  }

  test('request remembers it asked, so a refusal reads as denied', () async {
    final repo = await _repo(_FakeGeolocator(LocationPermission.denied));

    expect(await repo.request(), LocationAccess.denied);
    expect(await repo.check(), LocationAccess.denied);
  });

  test('openSettings opens the app settings page', () async {
    final platform = _FakeGeolocator(LocationPermission.deniedForever);
    final repo = await _repo(platform);

    expect(await repo.openSettings(), isTrue);
    expect(platform.settingsOpened, 1);
  });
}
