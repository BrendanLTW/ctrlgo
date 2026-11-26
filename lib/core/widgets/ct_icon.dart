import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// ctrlGo's line icons, copied from the design canvas (DESIGN §2.7): 24 grid,
/// round caps and joins, bundled in `assets/icons/`. Files use stroke 2;
/// [CtIconView] sets the stroke each place needs.
enum CtIcon {
  add('add'),
  explore('explore'),
  friends('friends'),
  go('go'),
  profile('profile'),
  saved('saved'),
  share('share');

  new(this.file);

  final String file;

  String get asset => 'assets/icons/$file.svg';
}

/// Stroke widths from the canvas.
abstract final class CtIconStroke {
  static const double nav = 1.7;
  static const double button = 1.8;
  static const double fab = 2.2;

  /// Outline on the filled Go arrow.
  static const double goArrow = 1.6;
}

/// Draws a [CtIcon]. Size and colour default to the surrounding `IconTheme`,
/// as `Icon` does. Decorative: screen readers skip it; label the button.
class CtIconView extends StatelessWidget {
  const new(
    this.icon, {
    this.size,
    this.color,
    this.stroke = CtIconStroke.button,
    super.key,
  });

  final CtIcon icon;
  final double? size;
  final Color? color;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    final theme = IconTheme.of(context);
    final side = size ?? theme.size ?? 24;
    final tint = color ?? theme.color;
    return Center(
      widthFactor: 1,
      heightFactor: 1,
      child: SvgPicture(
        _StrokeLoader(icon.asset, stroke),
        width: side,
        height: side,
        colorFilter: tint == null
            ? null
            : ColorFilter.mode(tint, BlendMode.srcIn),
        excludeFromSemantics: true,
      ),
    );
  }
}

/// Loads an icon with its stroke width swapped in, so one file serves the
/// 1.7 px nav and the 2.2 px FAB.
class _StrokeLoader extends SvgAssetLoader {
  const new(super.assetName, this.stroke);

  final double stroke;

  @override
  String provideSvg(ByteData? message) => super
      .provideSvg(message)
      .replaceFirst('stroke-width="2"', 'stroke-width="$stroke"');

  // The cache must tell strokes apart, or the first one loaded wins.
  @override
  SvgCacheKey cacheKey(BuildContext? context) => SvgCacheKey(
    keyData: (assetName, stroke),
    colorMapper: colorMapper,
    theme: getTheme(context),
  );

  @override
  int get hashCode => Object.hash(super.hashCode, stroke);

  @override
  bool operator ==(Object other) =>
      other is _StrokeLoader && super == other && other.stroke == stroke;
}
