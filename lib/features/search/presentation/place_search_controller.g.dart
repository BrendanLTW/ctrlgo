// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The Search screen's autocomplete. Lives as long as the screen, so
/// leaving Search ends the session.

@ProviderFor(PlaceSearchController)
final placeSearchControllerProvider = PlaceSearchControllerProvider._();

/// The Search screen's autocomplete. Lives as long as the screen, so
/// leaving Search ends the session.
final class PlaceSearchControllerProvider
    extends $NotifierProvider<PlaceSearchController, AutocompleteState> {
  /// The Search screen's autocomplete. Lives as long as the screen, so
  /// leaving Search ends the session.
  PlaceSearchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placeSearchControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placeSearchControllerHash();

  @$internal
  @override
  PlaceSearchController create() => PlaceSearchController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AutocompleteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AutocompleteState>(value),
    );
  }
}

String _$placeSearchControllerHash() =>
    r'05ae1daaca8202c5a6d21c97d050c1dda749b38d';

/// The Search screen's autocomplete. Lives as long as the screen, so
/// leaving Search ends the session.

abstract class _$PlaceSearchController extends $Notifier<AutocompleteState> {
  AutocompleteState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AutocompleteState, AutocompleteState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AutocompleteState, AutocompleteState>,
              AutocompleteState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
