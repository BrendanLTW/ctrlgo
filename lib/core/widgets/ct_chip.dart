import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/ct_text.dart';
import 'package:ctrlgo/core/widgets/ct_icon.dart';
import 'package:flutter/material.dart';

/// Pill chip (DESIGN §3 `CtChip`, canvas `.chip`). [floating] adds the soft
/// shadow chips get over the map.
class CtChip extends StatelessWidget {
  const new({
    required this.label,
    required this.onPressed,
    this.icon,
    this.floating = false,
    super.key,
  });

  final String label;
  final CtIcon? icon;
  final VoidCallback onPressed;
  final bool floating;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        shadows: floating
            ? [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 10,
                  color: c.ink.withValues(alpha: 0.08),
                ),
              ]
            : null,
      ),
      child: Material(
        color: c.surface,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            height: CtSize.chip,
            padding: const EdgeInsets.symmetric(horizontal: CtSpacing.cardPad),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6,
              children: [
                if (icon case final icon?)
                  CtIconView(icon, size: CtSize.chipIcon, color: c.ink2),
                Text(label, style: CtText.chip.copyWith(color: c.ink2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
