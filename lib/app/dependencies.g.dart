// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dependencies.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(clock)
final clockProvider = ClockProvider._();

final class ClockProvider extends $FunctionalProvider<Clock, Clock, Clock>
    with $Provider<Clock> {
  ClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clockHash();

  @$internal
  @override
  $ProviderElement<Clock> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Clock create(Ref ref) {
    return clock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Clock value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Clock>(value),
    );
  }
}

String _$clockHash() => r'55214d6539f7396a3ae1aa23b06eea79fdac0ebe';

@ProviderFor(positionSource)
final positionSourceProvider = PositionSourceProvider._();

final class PositionSourceProvider
    extends $FunctionalProvider<PositionSource, PositionSource, PositionSource>
    with $Provider<PositionSource> {
  PositionSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'positionSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$positionSourceHash();

  @$internal
  @override
  $ProviderElement<PositionSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PositionSource create(Ref ref) {
    return positionSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PositionSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PositionSource>(value),
    );
  }
}

String _$positionSourceHash() => r'b8e0c780aa07dcbc8e592cb05742a176cb9dc076';

@ProviderFor(connectivity)
final connectivityProvider = ConnectivityProvider._();

final class ConnectivityProvider
    extends $FunctionalProvider<Connectivity, Connectivity, Connectivity>
    with $Provider<Connectivity> {
  ConnectivityProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectivityProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectivityHash();

  @$internal
  @override
  $ProviderElement<Connectivity> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Connectivity create(Ref ref) {
    return connectivity(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Connectivity value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Connectivity>(value),
    );
  }
}

String _$connectivityHash() => r'ca5d398526794e812950290a753edca1fe48fe72';

/// Loaded once in `main` before the app starts, so reads are synchronous.

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

/// Loaded once in `main` before the app starts, so reads are synchronous.

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  /// Loaded once in `main` before the app starts, so reads are synchronous.
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'3223738ee8fa1d361c6e2f5b192a32337fc54b24';

@ProviderFor(locationPermissionRepository)
final locationPermissionRepositoryProvider =
    LocationPermissionRepositoryProvider._();

final class LocationPermissionRepositoryProvider
    extends
        $FunctionalProvider<
          LocationPermissionRepository,
          LocationPermissionRepository,
          LocationPermissionRepository
        >
    with $Provider<LocationPermissionRepository> {
  LocationPermissionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationPermissionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationPermissionRepositoryHash();

  @$internal
  @override
  $ProviderElement<LocationPermissionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocationPermissionRepository create(Ref ref) {
    return locationPermissionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocationPermissionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocationPermissionRepository>(value),
    );
  }
}

String _$locationPermissionRepositoryHash() =>
    r'41636b45e5fb98d871e7128954785d8e0eb68877';

@ProviderFor(dio)
final dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'897c48fcc7ac596eb6ceb01a4e25c8406bec13be';

@ProviderFor(placeSearchRepository)
final placeSearchRepositoryProvider = PlaceSearchRepositoryProvider._();

final class PlaceSearchRepositoryProvider
    extends
        $FunctionalProvider<
          PlaceSearchRepository,
          PlaceSearchRepository,
          PlaceSearchRepository
        >
    with $Provider<PlaceSearchRepository> {
  PlaceSearchRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placeSearchRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placeSearchRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlaceSearchRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlaceSearchRepository create(Ref ref) {
    return placeSearchRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlaceSearchRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlaceSearchRepository>(value),
    );
  }
}

String _$placeSearchRepositoryHash() =>
    r'a1d231d6e7681f95234df79bc6ea687548bfdf25';
