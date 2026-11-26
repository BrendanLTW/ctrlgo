// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ct_map.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Both map styles (DESIGN §2.3), loaded together so a theme switch swaps
/// the style at once instead of flashing Google's default look.

@ProviderFor(mapStyles)
final mapStylesProvider = MapStylesProvider._();

/// Both map styles (DESIGN §2.3), loaded together so a theme switch swaps
/// the style at once instead of flashing Google's default look.

final class MapStylesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<Brightness, String>>,
          Map<Brightness, String>,
          FutureOr<Map<Brightness, String>>
        >
    with
        $FutureModifier<Map<Brightness, String>>,
        $FutureProvider<Map<Brightness, String>> {
  /// Both map styles (DESIGN §2.3), loaded together so a theme switch swaps
  /// the style at once instead of flashing Google's default look.
  MapStylesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapStylesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapStylesHash();

  @$internal
  @override
  $FutureProviderElement<Map<Brightness, String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<Brightness, String>> create(Ref ref) {
    return mapStyles(ref);
  }
}

String _$mapStylesHash() => r'014cb7d4c84063520c9969e2fa7b604ca5e5ffcb';
