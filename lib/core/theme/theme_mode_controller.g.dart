// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's theme mode. System by default.
// shortcut: in memory only; persist it when Settings › Theme lands (US-19).

@ProviderFor(ThemeModeController)
final themeModeControllerProvider = ThemeModeControllerProvider._();

/// The app's theme mode. System by default.
// shortcut: in memory only; persist it when Settings › Theme lands (US-19).
final class ThemeModeControllerProvider
    extends $NotifierProvider<ThemeModeController, ThemeMode> {
  /// The app's theme mode. System by default.
  // shortcut: in memory only; persist it when Settings › Theme lands (US-19).
  ThemeModeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeControllerHash();

  @$internal
  @override
  ThemeModeController create() => ThemeModeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeControllerHash() =>
    r'1c562e1ec6656e84c825eb862b0a232bb607d7ad';

/// The app's theme mode. System by default.
// shortcut: in memory only; persist it when Settings › Theme lands (US-19).

abstract class _$ThemeModeController extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
