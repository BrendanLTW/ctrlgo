import 'package:flutter/material.dart';

/// Family core colours shared with ctrlSpend and ctrlTask (DESIGN §2.1).
/// Read them with `context.ctColors`.
@immutable
class CtColors extends ThemeExtension<CtColors> {
  const new({
    required this.ground,
    required this.surface,
    required this.ink,
    required this.onInk,
    required this.ink2,
    required this.muted,
    required this.fill,
    required this.fill2,
    required this.border,
    required this.hero,
    required this.positive,
    required this.negative,
    required this.warning,
    required this.scrim,
  });

  static const light = CtColors(
    ground: Color(0xFFF7F8FA),
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF101828),
    onInk: Color(0xFFFFFFFF),
    ink2: Color(0xFF344054),
    muted: Color(0xFF5B6B86),
    fill: Color(0xFFEEF1F6),
    fill2: Color(0xFFF2F4F7),
    border: Color(0xFFD0D5DD),
    hero: Color(0xFF101828),
    positive: Color(0xFF067647),
    negative: Color(0xFFD92D20),
    warning: Color(0xFFB54708),
    scrim: Color(0x6B101828), // navy 42%
  );

  static const dark = CtColors(
    ground: Color(0xFF0B1018),
    surface: Color(0xFF161D29),
    ink: Color(0xFFF2F4F7),
    onInk: Color(0xFF0B1018),
    ink2: Color(0xFFD0D5DD),
    muted: Color(0xFF98A2B3),
    fill: Color(0xFF232C3A),
    fill2: Color(0xFF232C3A),
    border: Color(0xFF475467),
    hero: Color(0xFF1C2536),
    positive: Color(0xFF47CD89),
    negative: Color(0xFFF97066),
    warning: Color(0xFFFDB022),
    scrim: Color(0x99000000), // black 60%
  );

  /// Scaffold background.
  final Color ground;

  /// Cards, sheets, nav.
  final Color surface;

  /// Text, primary buttons, selected states.
  final Color ink;

  /// Text on ink.
  final Color onInk;

  /// Secondary text on tinted fills.
  final Color ink2;

  /// Meta text, inactive icons.
  final Color muted;

  /// Chips, soft buttons, dividers.
  final Color fill;

  /// Inset areas inside sheets.
  final Color fill2;

  /// Toggles off, radio rings.
  final Color border;

  /// Dark hero cards, turn banner.
  final Color hero;

  /// Arrived, open now, on time.
  final Color positive;

  /// Destructive, closed, speeding.
  final Color negative;

  /// Delays, closing soon, estimates.
  final Color warning;

  /// Behind modal sheets and dialogs.
  final Color scrim;

  @visibleForTesting
  Map<String, Color> get tokens => {
    'ground': ground,
    'surface': surface,
    'ink': ink,
    'onInk': onInk,
    'ink2': ink2,
    'muted': muted,
    'fill': fill,
    'fill2': fill2,
    'border': border,
    'hero': hero,
    'positive': positive,
    'negative': negative,
    'warning': warning,
    'scrim': scrim,
  };

  // Tokens are fixed per theme; nothing overrides them.
  @override
  CtColors copyWith() => this;

  @override
  CtColors lerp(CtColors? other, double t) {
    if (other == null) return this;
    return CtColors(
      ground: Color.lerp(ground, other.ground, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      onInk: Color.lerp(onInk, other.onInk, t)!,
      ink2: Color.lerp(ink2, other.ink2, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      fill: Color.lerp(fill, other.fill, t)!,
      fill2: Color.lerp(fill2, other.fill2, t)!,
      border: Color.lerp(border, other.border, t)!,
      hero: Color.lerp(hero, other.hero, t)!,
      positive: Color.lerp(positive, other.positive, t)!,
      negative: Color.lerp(negative, other.negative, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
    );
  }
}

extension CtColorsContext on BuildContext {
  CtColors get ctColors => Theme.of(this).extension<CtColors>()!;
}
