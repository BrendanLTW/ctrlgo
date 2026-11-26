// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_access_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The current [LocationAccess]. Re-checked whenever the app comes back to
/// the foreground, since the user may have changed it in Settings.

@ProviderFor(LocationAccessController)
final locationAccessControllerProvider = LocationAccessControllerProvider._();

/// The current [LocationAccess]. Re-checked whenever the app comes back to
/// the foreground, since the user may have changed it in Settings.
final class LocationAccessControllerProvider
    extends $AsyncNotifierProvider<LocationAccessController, LocationAccess> {
  /// The current [LocationAccess]. Re-checked whenever the app comes back to
  /// the foreground, since the user may have changed it in Settings.
  LocationAccessControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationAccessControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationAccessControllerHash();

  @$internal
  @override
  LocationAccessController create() => LocationAccessController();
}

String _$locationAccessControllerHash() =>
    r'2876c67308ba1f440df41d5a8c5c6967a3f0d8f9';

/// The current [LocationAccess]. Re-checked whenever the app comes back to
/// the foreground, since the user may have changed it in Settings.

abstract class _$LocationAccessController
    extends $AsyncNotifier<LocationAccess> {
  FutureOr<LocationAccess> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<LocationAccess>, LocationAccess>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<LocationAccess>, LocationAccess>,
              AsyncValue<LocationAccess>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
