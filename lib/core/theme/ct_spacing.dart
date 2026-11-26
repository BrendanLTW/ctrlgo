/// Spacing from DESIGN §2.6. Ranged tokens use one value; screens tune them
/// against the canvas.
abstract final class CtSpacing {
  /// Screen margin.
  static const double screenX = 16;

  /// Between cards (10–12).
  static const double cardGap = 12;

  /// Inside cards (14–20).
  static const double cardPad = 16;

  /// Before section labels (20–24).
  static const double sectionTop = 22;
}

/// Sizes from DESIGN §2.6–2.7.
abstract final class CtSize {
  /// Minimum touch target.
  static const double target = 44;

  /// Map buttons.
  static const double mapButton = 48;

  /// Anything used while driving.
  static const double drivingTarget = 56;

  static const double icon = 24;
  static const double iconStroke = 1.8;

  static const double tileLg = 48;
  static const double tileMd = 40;
  static const double tileSm = 28;

  // Nav bar and FAB, from the canvas `.nav` and `.fab` rules.
  static const double navBottom = 24;
  static const double navWidth = 278;
  static const double navHeight = 68;
  static const double navPadX = 8;
  static const double navGap = 2;
  static const double navItemHeight = 52;
  static const double navItemPadX = 14;
  static const double navItemGap = 8;
  static const double fab = 64;

  // Buttons and state sheets, from the canvas `.btn`, `.link` and `.eb`.
  static const double button = 58;
  static const double textButton = 48;
  static const double stateIcon = 96;
  static const double stateGlyph = 40;

  /// List rows inside sheets (`.gi` at 52).
  static const double rowCompact = 52;

  // Explore map overlays, from the canvas `Main` artboard.
  static const double floatingSearch = 56;
  static const double chip = 40;
  static const double chipIcon = 18;
  static const double iconButtonSm = 44;

  /// Bottom of the map buttons, leaving room for the commute card and mode
  /// selector above the nav.
  static const double mapButtonsBottom = 268;
  static const double fabIcon = 28;
}
