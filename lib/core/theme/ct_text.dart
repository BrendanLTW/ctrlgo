import 'package:flutter/widgets.dart';

const _family = 'Poppins';
const _tabular = [FontFeature.tabularFigures()];

/// Text styles from DESIGN §2.5, all Poppins with tabular figures.
///
/// Styles carry no colour, so text takes `ink` from the theme unless a widget
/// sets one. `label` is uppercase in the designs; the ARB copy holds the
/// uppercase text.
abstract final class CtText {
  /// "450 m" in the turn banner.
  static const turnDistance = TextStyle(
    fontFamily: _family,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.8,
    fontFeatures: _tabular,
  );

  /// Arrival time in the nav panel.
  static const eta = TextStyle(
    fontFamily: _family,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
    fontFeatures: _tabular,
  );

  /// Tab titles.
  static const pageTitle = TextStyle(
    fontFamily: _family,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    fontFeatures: _tabular,
  );

  /// Route time, group name.
  static const heroValue = TextStyle(
    fontFamily: _family,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
    fontFeatures: _tabular,
  );

  /// Sheet and app-bar titles.
  static const header = TextStyle(
    fontFamily: _family,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFeatures: _tabular,
  );

  /// List rows, turn instruction.
  static const rowTitle = TextStyle(
    fontFamily: _family,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFeatures: _tabular,
  );

  /// Body and field text. Use `w500` via copyWith for emphasis.
  static const body = TextStyle(
    fontFamily: _family,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    fontFeatures: _tabular,
  );

  /// Secondary lines.
  static const meta = TextStyle(
    fontFamily: _family,
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontFeatures: _tabular,
  );

  /// Section labels (uppercase copy).
  static const label = TextStyle(
    fontFamily: _family,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.7,
    fontFeatures: _tabular,
  );

  /// Chips, pills.
  static const chip = TextStyle(
    fontFamily: _family,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFeatures: _tabular,
  );

  /// Primary buttons (canvas `.btn`; not in DESIGN §2.5).
  static const button = TextStyle(
    fontFamily: _family,
    fontSize: 17,
    fontWeight: FontWeight.w600,
    fontFeatures: _tabular,
  );

  /// Mode labels, leg chips, ETA bubbles (DESIGN gives 11–12).
  static const small = TextStyle(
    fontFamily: _family,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontFeatures: _tabular,
  );
}
