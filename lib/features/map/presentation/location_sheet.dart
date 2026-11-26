import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_radius.dart';
import 'package:ctrlgo/core/theme/ct_shadows.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/ct_text.dart';
import 'package:ctrlgo/core/theme/ct_tones.dart';
import 'package:ctrlgo/core/theme/go_colors.dart';
import 'package:ctrlgo/core/widgets/ct_button.dart';
import 'package:ctrlgo/core/widgets/ct_icon.dart';
import 'package:ctrlgo/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// Bottom sheet over the dimmed map when the app can't use location: the
/// explainer before the first prompt, or `LocDenied` after a refusal.
class LocationSheet extends StatelessWidget {
  /// Explains why before the system prompt (no artboard; built from
  /// LocDenied's parts).
  const new ask({required VoidCallback onContinue, super.key})
    : _denied = false,
      _onPrimary = onContinue,
      _onSearch = null;

  /// The `LocDenied` artboard.
  const new denied({
    required VoidCallback onOpenSettings,
    required VoidCallback onSearchWithoutLocation,
    super.key,
  }) : _denied = true,
       _onPrimary = onOpenSettings,
       _onSearch = onSearchWithoutLocation;

  final bool _denied;
  final VoidCallback _onPrimary;
  final VoidCallback? _onSearch;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    final go = context.goColors;
    final l10n = context.l10n;
    // Keep the actions clear of the floating nav.
    final bottom =
        CtSize.navBottom +
        CtSize.navHeight +
        CtSpacing.cardGap +
        MediaQuery.viewPaddingOf(context).bottom;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(CtRadius.r32),
        ),
        boxShadow: context.shadows.floating,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          CtSpacing.screenX,
          CtSpacing.sectionTop,
          CtSpacing.screenX,
          bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: CtSize.stateIcon,
              height: CtSize.stateIcon,
              decoration: BoxDecoration(
                color: go.goSoft,
                shape: BoxShape.circle,
              ),
              child: CtIconView(
                _denied ? CtIcon.locationOff : CtIcon.location,
                size: CtSize.stateGlyph,
                color: go.go,
                stroke: CtIconStroke.state,
              ),
            ),
            const SizedBox(height: CtSpacing.sectionTop),
            // The canvas insets state text 32 px from the sheet edge.
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CtSpacing.screenX,
              ),
              child: Column(
                spacing: 8,
                children: [
                  Text(
                    _denied ? l10n.locationOffTitle : l10n.locationAskTitle,
                    style: CtText.heroValue.copyWith(letterSpacing: 0),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _denied ? l10n.locationOffBody : l10n.locationAskBody,
                    style: CtText.body.copyWith(color: c.muted, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            if (_denied) ...[
              const SizedBox(height: CtSpacing.cardGap),
              const _SettingsPath(),
            ],
            const SizedBox(height: CtSpacing.cardPad),
            CtButton(
              label: _denied ? l10n.openSettings : l10n.locationAskContinue,
              onPressed: _onPrimary,
            ),
            if (_onSearch case final onSearch?)
              CtTextButton(
                label: l10n.searchWithoutLocation,
                onPressed: onSearch,
              ),
          ],
        ),
      ),
    );
  }
}

/// Where to switch location back on, on this platform.
class _SettingsPath extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    final tone = context.tones.blue;
    final l10n = context.l10n;
    final ios = Theme.of(context).platform == TargetPlatform.iOS;
    return Container(
      constraints: const BoxConstraints(minHeight: CtSize.rowCompact),
      padding: const EdgeInsets.symmetric(
        horizontal: CtSpacing.cardPad,
        vertical: CtSpacing.cardGap,
      ),
      decoration: BoxDecoration(
        color: c.fill2,
        borderRadius: BorderRadius.circular(CtRadius.r28),
      ),
      child: Row(
        spacing: CtSpacing.cardGap,
        children: [
          Container(
            width: CtSize.tileSm,
            height: CtSize.tileSm,
            decoration: BoxDecoration(
              color: tone.tile,
              borderRadius: BorderRadius.circular(CtRadius.r9),
            ),
            child: CtIconView(
              CtIcon.crosshair,
              size: CtSize.icon * 0.625,
              color: tone.fg,
              stroke: CtIconStroke.tile,
            ),
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: ios
                    ? l10n.locationSettingsPathIos
                    : l10n.locationSettingsPathAndroid,
                children: [
                  TextSpan(
                    text: ios
                        ? l10n.locationSettingsValueIos
                        : l10n.locationSettingsValueAndroid,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              style: CtText.chip.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
