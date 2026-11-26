import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_shadows.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/go_colors.dart';
import 'package:ctrlgo/core/widgets/ct_icon.dart';
import 'package:flutter/material.dart';

/// Round 48 px button floating on the map (canvas `.fbtn`). [active] tints
/// the icon go blue, e.g. recentre while the map follows you.
class MapButton extends StatelessWidget {
  const new({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.active = false,
    super.key,
  });

  final CtIcon icon;
  final String label;
  final VoidCallback onPressed;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    return Semantics(
      button: true,
      label: label,
      selected: active,
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          shadows: context.shadows.floating,
        ),
        child: Material(
          color: c.surface,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox.square(
              dimension: CtSize.mapButton,
              child: CtIconView(
                icon,
                size: CtSize.icon,
                color: active ? context.goColors.go : c.ink,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
