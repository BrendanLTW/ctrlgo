import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_shadows.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/widgets/ct_icon.dart';
import 'package:flutter/material.dart';

/// Round ink button beside the nav: the current tab's primary action.
class CtFab extends StatelessWidget {
  const new({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final CtIcon icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          shadows: context.shadows.fab,
        ),
        child: Material(
          color: c.ink,
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox.square(
              dimension: CtSize.fab,
              child: CtIconView(
                icon,
                size: CtSize.fabIcon,
                color: c.onInk,
                stroke: icon == CtIcon.go
                    ? CtIconStroke.goArrow
                    : CtIconStroke.fab,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
