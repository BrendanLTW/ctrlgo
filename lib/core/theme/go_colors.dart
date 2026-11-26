import 'package:flutter/material.dart';

/// ctrlGo additions (DESIGN §2.2). Go blue means "you": only your position,
/// your route and your sharing state. Read them with `context.goColors`.
@immutable
class GoColors extends ThemeExtension<GoColors> {
  const new({
    required this.go,
    required this.onGo,
    required this.goSoft,
    required this.goHalo,
    required this.altRoute,
    required this.routeCasing,
    required this.puckRing,
  });

  static const light = GoColors(
    go: Color(0xFF3A6BF0),
    onGo: Color(0xFFFFFFFF),
    goSoft: Color(0xFFDCE6FF),
    goHalo: Color(0x293A6BF0), // go 16%
    altRoute: Color(0xFFA3ADBF),
    routeCasing: Color(0xFFFFFFFF),
    puckRing: Color(0xFFFFFFFF),
  );

  static const dark = GoColors(
    go: Color(0xFF6C95FF),
    onGo: Color(0xFF0B1018),
    goSoft: Color(0x386C95FF), // go 22%
    goHalo: Color(0x386C95FF), // go 22%
    altRoute: Color(0xFF4A566B),
    routeCasing: Color(0xFF0B1018),
    puckRing: Color(0xFFFFFFFF),
  );

  /// Your puck, your route, selected ETA bubble, sharing icon.
  final Color go;

  /// Text and icons on [go].
  final Color onGo;

  /// Sharing banner, location-off tile.
  final Color goSoft;

  /// Puck accuracy halo and heading cone.
  final Color goHalo;

  /// Unselected routes, travelled route, estimated position.
  final Color altRoute;

  /// Outline under route lines.
  final Color routeCasing;

  /// Ring round the live puck: white in both themes (canvas `.puck`).
  final Color puckRing;

  @visibleForTesting
  Map<String, Color> get tokens => {
    'go': go,
    'onGo': onGo,
    'goSoft': goSoft,
    'goHalo': goHalo,
    'altRoute': altRoute,
    'routeCasing': routeCasing,
    'puckRing': puckRing,
  };

  // Tokens are fixed per theme; nothing overrides them.
  @override
  GoColors copyWith() => this;

  @override
  GoColors lerp(GoColors? other, double t) {
    if (other == null) return this;
    return GoColors(
      go: Color.lerp(go, other.go, t)!,
      onGo: Color.lerp(onGo, other.onGo, t)!,
      goSoft: Color.lerp(goSoft, other.goSoft, t)!,
      goHalo: Color.lerp(goHalo, other.goHalo, t)!,
      altRoute: Color.lerp(altRoute, other.altRoute, t)!,
      routeCasing: Color.lerp(routeCasing, other.routeCasing, t)!,
      puckRing: Color.lerp(puckRing, other.puckRing, t)!,
    );
  }
}

// Not `context.go`: go_router already defines that.
extension GoColorsContext on BuildContext {
  GoColors get goColors => Theme.of(this).extension<GoColors>()!;
}
