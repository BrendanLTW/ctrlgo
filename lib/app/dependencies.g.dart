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

/// The web demo has no GPS worth using, so it replays the demo drive.

@ProviderFor(positionSource)
final positionSourceProvider = PositionSourceProvider._();

/// The web demo has no GPS worth using, so it replays the demo drive.

final class PositionSourceProvider
    extends $FunctionalProvider<PositionSource, PositionSource, PositionSource>
    with $Provider<PositionSource> {
  /// The web demo has no GPS worth using, so it replays the demo drive.
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

String _$positionSourceHash() => r'8557e4836597d96c047b7e7f392229b35955afd0';

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
