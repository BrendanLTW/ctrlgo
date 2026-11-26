import 'package:flutter/material.dart';

/// One pastel tone: tile background, foreground on the tile, and the
/// stronger chart or marker colour.
@immutable
class ToneSet {
  const new(this.tile, this.fg, this.chart);

  new lerp(ToneSet a, ToneSet b, double t)
    : tile = Color.lerp(a.tile, b.tile, t)!,
      fg = Color.lerp(a.fg, b.fg, t)!,
      chart = Color.lerp(a.chart, b.chart, t)!;

  final Color tile;
  final Color fg;
  final Color chart;
}

/// The eight family tones (DESIGN §2.1) for icon tiles, friend avatars,
/// transit lines and traffic. Read them with `context.tones`.
@immutable
class CtTones extends ThemeExtension<CtTones> {
  const new({
    required this.orange,
    required this.yellow,
    required this.green,
    required this.blue,
    required this.purple,
    required this.pink,
    required this.red,
    required this.grey,
  });

  static const light = CtTones(
    orange: ToneSet(Color(0xFFFFE2B8), Color(0xFFC25E00), Color(0xFFFB8C00)),
    yellow: ToneSet(Color(0xFFFFF0B8), Color(0xFF8A6100), Color(0xFFF5B800)),
    green: ToneSet(Color(0xFFC9F3D5), Color(0xFF1E8A43), Color(0xFF17B26A)),
    blue: ToneSet(Color(0xFFCDE6FB), Color(0xFF1769C2), Color(0xFF2196F3)),
    purple: ToneSet(Color(0xFFE4DBF7), Color(0xFF6D3FD1), Color(0xFF7C4DDB)),
    pink: ToneSet(Color(0xFFFBD3E1), Color(0xFFC8174F), Color(0xFFF0457A)),
    red: ToneSet(Color(0xFFFEE4E2), Color(0xFFD92D20), Color(0xFFF04438)),
    grey: ToneSet(Color(0xFFEEF1F6), Color(0xFF5B6B86), Color(0xFF98A2B3)),
  );

  // Dark tiles are the chart colour at the alpha DESIGN gives (20–26%).
  static const dark = CtTones(
    orange: ToneSet(Color(0x33FFB547), Color(0xFFFFB547), Color(0xFFFFB547)),
    yellow: ToneSet(Color(0x33FFD34D), Color(0xFFFFD34D), Color(0xFFFFD34D)),
    green: ToneSet(Color(0x3847CD89), Color(0xFF5BD996), Color(0xFF47CD89)),
    blue: ToneSet(Color(0x386CB8FF), Color(0xFF6CB8FF), Color(0xFF6CB8FF)),
    purple: ToneSet(Color(0x42B69BFF), Color(0xFFB69BFF), Color(0xFFB69BFF)),
    pink: ToneSet(Color(0x38FF7AA2), Color(0xFFFF7AA2), Color(0xFFFF7AA2)),
    red: ToneSet(Color(0x38F97066), Color(0xFFFF8A80), Color(0xFFF97066)),
    grey: ToneSet(Color(0xFF232C3A), Color(0xFF98A2B3), Color(0xFF475467)),
  );

  final ToneSet orange;
  final ToneSet yellow;
  final ToneSet green;
  final ToneSet blue;
  final ToneSet purple;
  final ToneSet pink;
  final ToneSet red;
  final ToneSet grey;

  /// In DESIGN order (or, ye, gr, bl, pu, pk, rd, gy).
  List<ToneSet> get all => [
    orange,
    yellow,
    green,
    blue,
    purple,
    pink,
    red,
    grey,
  ];

  // Tokens are fixed per theme; nothing overrides them.
  @override
  CtTones copyWith() => this;

  @override
  CtTones lerp(CtTones? other, double t) {
    if (other == null) return this;
    return CtTones(
      orange: ToneSet.lerp(orange, other.orange, t),
      yellow: ToneSet.lerp(yellow, other.yellow, t),
      green: ToneSet.lerp(green, other.green, t),
      blue: ToneSet.lerp(blue, other.blue, t),
      purple: ToneSet.lerp(purple, other.purple, t),
      pink: ToneSet.lerp(pink, other.pink, t),
      red: ToneSet.lerp(red, other.red, t),
      grey: ToneSet.lerp(grey, other.grey, t),
    );
  }
}

extension CtTonesContext on BuildContext {
  CtTones get tones => Theme.of(this).extension<CtTones>()!;
}
