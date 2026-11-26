// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_puck.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Painted once at the screen's pixel ratio. The puck is a map marker, not
/// a widget, so it stays pinned to its coordinate while the map pans.

@ProviderFor(puckIcons)
final puckIconsProvider = PuckIconsProvider._();

/// Painted once at the screen's pixel ratio. The puck is a map marker, not
/// a widget, so it stays pinned to its coordinate while the map pans.

final class PuckIconsProvider
    extends
        $FunctionalProvider<
          AsyncValue<PuckIcons>,
          PuckIcons,
          FutureOr<PuckIcons>
        >
    with $FutureModifier<PuckIcons>, $FutureProvider<PuckIcons> {
  /// Painted once at the screen's pixel ratio. The puck is a map marker, not
  /// a widget, so it stays pinned to its coordinate while the map pans.
  PuckIconsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'puckIconsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$puckIconsHash();

  @$internal
  @override
  $FutureProviderElement<PuckIcons> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PuckIcons> create(Ref ref) {
    return puckIcons(ref);
  }
}

String _$puckIconsHash() => r'1af0bd2100b4e8e3d09fd0a27ee2f7169822f072';
