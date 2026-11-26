import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_shadows.dart';
import 'package:ctrlgo/core/theme/ct_theme.dart';
import 'package:ctrlgo/core/theme/ct_tones.dart';
import 'package:ctrlgo/core/theme/go_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final (name, theme, c) in [
    ('light', buildLightTheme(), CtColors.light),
    ('dark', buildDarkTheme(), CtColors.dark),
  ]) {
    group('$name theme', () {
      test('maps family core onto ColorScheme as DESIGN §9 says', () {
        final s = theme.colorScheme;
        expect(s.surface, c.ground);
        expect(s.surfaceContainerLowest, c.surface);
        expect(s.primary, c.ink);
        expect(s.onPrimary, c.onInk);
        expect(s.onSurfaceVariant, c.muted);
        expect(s.surfaceContainerHigh, c.fill);
        expect(s.outlineVariant, c.fill);
        expect(theme.scaffoldBackgroundColor, c.ground);
      });

      test('carries every token extension', () {
        expect(theme.extension<CtColors>(), c);
        expect(theme.extension<GoColors>(), isNotNull);
        expect(theme.extension<CtTones>(), isNotNull);
        expect(theme.extension<CtShadows>(), isNotNull);
      });

      test('text uses Poppins with tabular figures', () {
        final body = theme.textTheme.bodyMedium!;
        expect(body.fontFamily, 'Poppins');
        expect(body.fontFeatures, contains(const FontFeature.tabularFigures()));
      });
    });
  }

  test('white text on go reaches AA (DESIGN §2.2)', () {
    final ratio = _contrast(GoColors.light.go, GoColors.light.onGo);
    expect(ratio, greaterThanOrEqualTo(4.5));
  });
}

double _contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final (hi, lo) = la > lb ? (la, lb) : (lb, la);
  return (hi + 0.05) / (lo + 0.05);
}
