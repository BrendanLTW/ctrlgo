import 'package:ctrlgo/app/dependencies.dart';
import 'package:ctrlgo/core/location/location_access.dart';
import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_access_controller.g.dart';

/// The current [LocationAccess]. Re-checked whenever the app comes back to
/// the foreground, since the user may have changed it in Settings.
@Riverpod(keepAlive: true)
class LocationAccessController extends _$LocationAccessController {
  LocationPermissionRepository get _repo =>
      ref.read(locationPermissionRepositoryProvider);

  @override
  Future<LocationAccess> build() {
    final lifecycle = AppLifecycleListener(onResume: recheck);
    ref.onDispose(lifecycle.dispose);
    return ref.watch(locationPermissionRepositoryProvider).check();
  }

  Future<void> recheck() async => state = AsyncData(await _repo.check());

  /// After the explainer: show the system prompt.
  Future<void> request() async => state = AsyncData(await _repo.request());

  Future<void> openSettings() => _repo.openSettings();
}
