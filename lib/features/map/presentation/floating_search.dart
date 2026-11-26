import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_shadows.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/ct_text.dart';
import 'package:ctrlgo/core/widgets/ct_icon.dart';
import 'package:ctrlgo/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// "Where to?" pill over the map (DESIGN §3 `FloatingSearch`, canvas
/// `.fsearch`). Search and voice are side by side, not nested, so each is
/// its own control for screen readers.
class FloatingSearch extends StatelessWidget {
  const new({required this.onSearch, required this.onVoice, super.key});

  final VoidCallback onSearch;
  final VoidCallback onVoice;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        shadows: context.shadows.floating,
      ),
      child: Material(
        color: c.surface,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: CtSize.floatingSearch,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onSearch,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Row(
                      spacing: CtSpacing.cardGap,
                      children: [
                        CtIconView(
                          CtIcon.search,
                          size: CtSize.icon,
                          color: c.muted,
                        ),
                        Text(
                          l10n.whereTo,
                          style: CtText.body.copyWith(
                            color: c.muted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Semantics(
                  button: true,
                  label: l10n.voiceSearch,
                  excludeSemantics: true,
                  child: Material(
                    color: c.fill2,
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: onVoice,
                      child: SizedBox.square(
                        dimension: CtSize.iconButtonSm,
                        child: CtIconView(
                          CtIcon.mic,
                          size: CtSize.icon,
                          color: c.ink,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
