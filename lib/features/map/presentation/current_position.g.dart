// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_position.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's latest fix, only while location access is granted (asking
/// the GPS without permission just errors).

@ProviderFor(currentPosition)
final currentPositionProvider = CurrentPositionProvider._();

/// The user's latest fix, only while location access is granted (asking
/// the GPS without permission just errors).

final class CurrentPositionProvider
    extends
        $FunctionalProvider<
          AsyncValue<GeoPosition>,
          GeoPosition,
          Stream<GeoPosition>
        >
    with $FutureModifier<GeoPosition>, $StreamProvider<GeoPosition> {
  /// The user's latest fix, only while location access is granted (asking
  /// the GPS without permission just errors).
  CurrentPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentPositionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentPositionHash();

  @$internal
  @override
  $StreamProviderElement<GeoPosition> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<GeoPosition> create(Ref ref) {
    return currentPosition(ref);
  }
}

String _$currentPositionHash() => r'154fbabf6c53da4944b3a64b46f4d16af91edc1b';
