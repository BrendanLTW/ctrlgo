import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_shadows.dart';
import 'package:ctrlgo/core/theme/ct_text.dart';
import 'package:ctrlgo/core/theme/ct_tones.dart';
import 'package:ctrlgo/core/theme/go_colors.dart';
import 'package:flutter/material.dart';

ThemeData buildLightTheme() => _build(
  Brightness.light,
  CtColors.light,
  GoColors.light,
  CtTones.light,
  CtShadows.light,
);

ThemeData buildDarkTheme() => _build(
  Brightness.dark,
  CtColors.dark,
  GoColors.dark,
  CtTones.dark,
  CtShadows.dark,
);

ThemeData _build(
  Brightness brightness,
  CtColors c,
  GoColors go,
  CtTones tones,
  CtShadows shadows,
) {
  return ThemeData(
    brightness: brightness,
    fontFamily: 'Poppins',
    // Mapping from DESIGN §9.
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: c.ink,
      onPrimary: c.onInk,
      secondary: c.ink,
      onSecondary: c.onInk,
      error: c.negative,
      onError: c.onInk,
      surface: c.ground,
      onSurface: c.ink,
      onSurfaceVariant: c.muted,
      surfaceContainerLowest: c.surface,
      surfaceContainerHigh: c.fill,
      outline: c.border,
      outlineVariant: c.fill,
      scrim: c.scrim,
    ),
    scaffoldBackgroundColor: c.ground,
    dividerColor: c.fill,
    textTheme: const TextTheme(
      displaySmall: CtText.turnDistance,
      headlineMedium: CtText.pageTitle,
      headlineSmall: CtText.heroValue,
      titleLarge: CtText.header,
      titleMedium: CtText.rowTitle,
      bodyLarge: CtText.body,
      bodyMedium: CtText.body,
      bodySmall: CtText.meta,
      labelLarge: CtText.chip,
      labelMedium: CtText.label,
      labelSmall: CtText.small,
    ).apply(bodyColor: c.ink, displayColor: c.ink),
    extensions: [c, go, tones, shadows],
  );
}
