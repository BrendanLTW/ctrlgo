import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_controller.g.dart';

/// The app's theme mode. System by default.
// shortcut: in memory only; persist it when Settings › Theme lands (US-19).
@Riverpod(keepAlive: true)
class ThemeModeController extends _$ThemeModeController {
  @override
  ThemeMode build() => ThemeMode.system;

  // A method rather than a setter so callers read as an action.
  // ignore: use_setters_to_change_properties
  void set(ThemeMode mode) => state = mode;
}
