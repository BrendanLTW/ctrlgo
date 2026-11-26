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
}
