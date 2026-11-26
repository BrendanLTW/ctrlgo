import 'package:ctrlgo/core/location/location_access.dart';
import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_shadows.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/theme_mode_controller.dart';
import 'package:ctrlgo/features/map/presentation/ct_map.dart';
import 'package:ctrlgo/features/map/presentation/location_access_controller.dart';
import 'package:ctrlgo/features/map/presentation/location_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Explore tab (`Main` artboard). For now the themed map plus the location
/// permission flow; search, chips, puck and the rest arrive in 1.2.
class ExploreScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  /// "Search without location" hides LocDenied for this visit.
  var _browseWithoutLocation = false;

  @override
  Widget build(BuildContext context) {
    final access = ref.watch(locationAccessControllerProvider).value;
    final controller = ref.read(locationAccessControllerProvider.notifier);
    final sheet = switch (access) {
      LocationAccess.notAsked => LocationSheet.ask(
        onContinue: controller.request,
      ),
      LocationAccess.denied when !_browseWithoutLocation =>
        LocationSheet.denied(
          onOpenSettings: controller.openSettings,
          // shortcut: just reveals the map until Search (1.3) exists; then
          // open Search here.
          onSearchWithoutLocation: () =>
              setState(() => _browseWithoutLocation = true),
        ),
      _ => null,
    };

    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: CtMap()),
          if (sheet != null) ...[
            // Dim the map behind the sheet (canvas `.mapdim`).
            Positioned.fill(
              child: IgnorePointer(
                child: ColoredBox(
                  color: context.ctColors.ground.withValues(alpha: 0.55),
                ),
              ),
            ),
            Positioned(left: 0, right: 0, bottom: 0, child: sheet),
          ],
          if (kDebugMode) const _DebugThemeToggle(),
        ],
      ),
    );
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
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(CtSpacing.screenX),
          child: DecoratedBox(
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
          ),
        ),
      ),
    );
  }
}
