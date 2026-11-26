import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_shadows.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/theme_mode_controller.dart';
import 'package:ctrlgo/features/map/presentation/ct_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Explore tab (`Main` artboard). For now just the themed map; search,
/// chips, puck and the rest arrive in 1.2.
class ExploreScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: CtMap()),
          if (kDebugMode) _DebugThemeToggle(),
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
