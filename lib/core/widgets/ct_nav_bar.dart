import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_shadows.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/ct_text.dart';
import 'package:ctrlgo/core/widgets/ct_icon.dart';
import 'package:flutter/material.dart';

@immutable
class CtNavItem {
  const new({required this.icon, required this.label});

  final CtIcon icon;
  final String label;
}

/// Floating pill nav (DESIGN §3). Unselected items show only their icon;
/// the selected one adds its label on a `fill` pill.
class CtNavBar extends StatelessWidget {
  const new({
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    required this.semanticLabel,
    super.key,
  });

  final List<CtNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: semanticLabel,
      child: Container(
        width: CtSize.navWidth,
        height: CtSize.navHeight,
        padding: const EdgeInsets.symmetric(horizontal: CtSize.navPadX),
        decoration: ShapeDecoration(
          color: context.ctColors.surface,
          shape: const StadiumBorder(),
          shadows: context.shadows.floating,
        ),
        child: Row(
          spacing: CtSize.navGap,
          children: [
            for (final (i, item) in items.indexed)
              _NavButton(
                item: item,
                selected: i == selectedIndex,
                onTap: () => onSelected(i),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const new({required this.item, required this.selected, required this.onTap});

  final CtNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    final button = Semantics(
      button: true,
      selected: selected,
      label: item.label,
      excludeSemantics: true,
      child: Material(
        color: selected ? c.fill : Colors.transparent,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: CtSize.navItemHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: selected ? CtSize.navItemPadX : 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: CtSize.navItemGap,
                children: [
                  CtIconView(
                    item.icon,
                    size: CtSize.icon,
                    color: c.ink,
                    stroke: CtIconStroke.nav,
                  ),
                  if (selected)
                    // shortcut: the 278 px pill only fits the label at 1x;
                    // revisit in the 5.5 accessibility pass.
                    MediaQuery.withNoTextScaling(
                      child: Text(
                        item.label,
                        style: CtText.chip.copyWith(color: c.ink),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    return selected ? button : Expanded(child: button);
  }
}
