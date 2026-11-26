import 'package:flutter/material.dart';

/// Shadow for floating things only: nav, FAB, map buttons, floating search,
/// sheets, toasts, dialogs (DESIGN §2.6). Cards are flat.
/// Read it with `context.shadows`.
@immutable
class CtShadows extends ThemeExtension<CtShadows> {
  const new({required this.floating});

  static const light = CtShadows(
    floating: [
      BoxShadow(
        offset: Offset(0, 8),
        blurRadius: 28,
        color: Color.fromRGBO(16, 24, 40, 0.08),
      ),
    ],
  );

  static const dark = CtShadows(
    floating: [
      BoxShadow(
        offset: Offset(0, 8),
        blurRadius: 28,
        color: Color.fromRGBO(0, 0, 0, 0.5),
      ),
    ],
  );

  final List<BoxShadow> floating;

  // Tokens are fixed per theme; nothing overrides them.
  @override
  CtShadows copyWith() => this;

  @override
  CtShadows lerp(CtShadows? other, double t) {
    if (other == null) return this;
    return CtShadows(
      floating: BoxShadow.lerpList(floating, other.floating, t)!,
    );
  }
}

extension CtShadowsContext on BuildContext {
  CtShadows get shadows => Theme.of(this).extension<CtShadows>()!;
}
