import 'dart:async';

import 'package:ctrlgo/app/app_shell.dart';
import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/core/location/location_access.dart';
import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_shadows.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/theme_mode_controller.dart';
import 'package:ctrlgo/core/widgets/ct_chip.dart';
import 'package:ctrlgo/core/widgets/ct_icon.dart';
import 'package:ctrlgo/features/map/presentation/ct_map.dart';
import 'package:ctrlgo/features/map/presentation/current_position.dart';
import 'package:ctrlgo/features/map/presentation/floating_search.dart';
import 'package:ctrlgo/features/map/presentation/location_access_controller.dart';
import 'package:ctrlgo/features/map/presentation/location_puck.dart';
import 'package:ctrlgo/features/map/presentation/location_sheet.dart';
import 'package:ctrlgo/features/map/presentation/map_button.dart';
import 'package:ctrlgo/features/search/presentation/search_screen.dart';
import 'package:ctrlgo/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Explore tab (`Main` artboard): the map with your puck, search, quick
/// destinations and map buttons, plus the location permission flow.
class ExploreScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  GoogleMapController? _map;

  /// The camera keeps you centred until you move the map yourself.
  var _following = true;
  var _traffic = false;

  /// "Search without location" hides LocDenied for this visit.
  var _browseWithoutLocation = false;

  LatLng? get _here => switch (ref.read(currentPositionProvider).value) {
    final p? => LatLng(p.lat, p.lng),
    null => null,
  };

  void _recentre() {
    setState(() => _following = true);
    if (_here case final here?) {
      unawaited(_map?.animateCamera(CameraUpdate.newLatLng(here)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    ref.listen(currentPositionProvider, (_, next) {
      if (_following && next.value != null) {
        unawaited(_map?.animateCamera(CameraUpdate.newLatLng(_here!)));
      }
    });
    final position = ref.watch(currentPositionProvider).value;
    final puckIcons = ref.watch(puckIconsProvider).value;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            // Any touch on the map means "let me look around".
            child: Listener(
              // Opaque so the touch registers here; the map still gets it.
              behavior: HitTestBehavior.opaque,
              onPointerDown: (_) {
                if (_following) setState(() => _following = false);
              },
              child: CtMap(
                markers: {
                  if (position != null && puckIcons != null)
                    _puck(position, puckIcons, l10n.yourLocation),
                },
                trafficEnabled: _traffic,
                onMapCreated: (map) {
                  _map = map;
                  if (_here case final here?) {
                    unawaited(map.moveCamera(CameraUpdate.newLatLng(here)));
                  }
                },
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 10,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: CtSpacing.screenX,
                    ),
                    child: FloatingSearch(
                      onSearch: () => context.push(searchRoute),
                      // shortcut: voice search has no task yet; it's a
                      // no-op until one is planned (DriveLock in 5.4).
                      onVoice: () {},
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: CtSpacing.screenX,
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        // shortcut: Home and Work need saved places (1.5)
                        // and routes (1.7); favourites join the row in 1.5.
                        CtChip(
                          icon: CtIcon.home,
                          label: l10n.chipHome,
                          floating: true,
                          onPressed: () {},
                        ),
                        CtChip(
                          icon: CtIcon.work,
                          label: l10n.chipWork,
                          floating: true,
                          onPressed: () {},
                        ),
                        CtChip(
                          icon: CtIcon.saved,
                          label: l10n.tabSaved,
                          floating: true,
                          onPressed: () => context.go(AppTab.saved.path),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: CtSpacing.screenX,
            bottom: CtSize.mapButtonsBottom,
            child: Column(
              spacing: 10,
              children: [
                if (kDebugMode) const _DebugThemeToggle(),
                MapButton(
                  icon: CtIcon.layers,
                  label: l10n.mapLayers,
                  active: _traffic,
                  onPressed: () => setState(() => _traffic = !_traffic),
                ),
                MapButton(
                  icon: CtIcon.recentre,
                  label: l10n.recentre,
                  active: _following && position != null,
                  onPressed: _recentre,
                ),
              ],
            ),
          ),
          ..._permissionSheet(context),
        ],
      ),
    );
  }

  Marker _puck(GeoPosition p, PuckIcons icons, String label) => Marker(
    markerId: const MarkerId('me'),
    position: LatLng(p.lat, p.lng),
    icon: icons.of(Theme.of(context).brightness, heading: p.headingDeg != null),
    // The cone is painted pointing north; the marker turns it.
    rotation: p.headingDeg ?? 0,
    anchor: const Offset(0.5, 0.5),
    flat: true,
    zIndexInt: 1,
    // Title for screen readers; tapping shows nothing.
    infoWindow: InfoWindow(title: label),
    consumeTapEvents: true,
  );

  List<Widget> _permissionSheet(BuildContext context) {
    final controller = ref.read(locationAccessControllerProvider.notifier);
    final sheet = switch (ref.watch(locationAccessControllerProvider).value) {
      LocationAccess.notAsked => LocationSheet.ask(
        onContinue: controller.request,
      ),
      LocationAccess.denied when !_browseWithoutLocation =>
        LocationSheet.denied(
          onOpenSettings: controller.openSettings,
          onSearchWithoutLocation: () {
            setState(() => _browseWithoutLocation = true);
            unawaited(context.push(searchRoute));
          },
        ),
      _ => null,
    };
    if (sheet == null) return const [];
    return [
      // Dim the map behind the sheet (canvas `.mapdim`).
      Positioned.fill(
        child: ColoredBox(
          color: context.ctColors.ground.withValues(alpha: 0.55),
        ),
      ),
      Positioned(left: 0, right: 0, bottom: 0, child: sheet),
    ];
  }
}

// shortcut: debug-only way to flip the theme until Settings › Theme exists;
// delete it then. Not user-facing, so not in the ARB.
class _DebugThemeToggle extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final c = context.ctColors;
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        shadows: context.shadows.floating,
      ),
      child: Material(
        color: c.surface,
        shape: const CircleBorder(),
        child: IconButton(
          tooltip: 'Toggle theme (debug)',
          constraints: const BoxConstraints.tightFor(
            width: CtSize.mapButton,
            height: CtSize.mapButton,
          ),
          icon: Icon(
            dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            color: c.ink,
          ),
          onPressed: () => ref
              .read(themeModeControllerProvider.notifier)
              .set(dark ? ThemeMode.light : ThemeMode.dark),
        ),
      ),
    );
  }
}
