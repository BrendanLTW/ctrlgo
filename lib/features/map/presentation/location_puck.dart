import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:ctrlgo/core/theme/go_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_puck.g.dart';

// Live puck geometry from the canvas `.puck` rule, in logical px.
const _dot = 11.0; // 22 px disc
const _ring = 3.0; // its border
const _halo = 14.0; // halo beyond the disc
const _coneTip = 37.0; // cone tip, above the centre
const _coneBase = 19.0; // cone base, above the centre
const _coneHalfWidth = 11.0;

/// Side of the square bitmap; the centre is the anchor.
const double puckSize = _coneTip * 2;

/// The four puck bitmaps: light or dark, with or without the heading cone.
class PuckIcons {
  const new(this._icons);

  /// One icon for every variant; tests use a plain marker.
  new all(BitmapDescriptor icon)
    : _icons = {
        for (final b in Brightness.values)
          for (final h in [true, false]) (b, h): icon,
      };

  final Map<(Brightness, bool), BitmapDescriptor> _icons;

  BitmapDescriptor of(Brightness brightness, {required bool heading}) =>
      _icons[(brightness, heading)]!;
}

/// Painted once at the screen's pixel ratio. The puck is a map marker, not
/// a widget, so it stays pinned to its coordinate while the map pans.
@Riverpod(keepAlive: true)
Future<PuckIcons> puckIcons(Ref ref) async {
  final pixelRatio =
      ui.PlatformDispatcher.instance.implicitView?.devicePixelRatio ?? 2;
  return PuckIcons({
    for (final (b, colors) in [
      (Brightness.light, GoColors.light),
      (Brightness.dark, GoColors.dark),
    ])
      for (final heading in [true, false])
        (b, heading): BytesMapBitmap(
          await paintPuck(colors, heading: heading, pixelRatio: pixelRatio),
          imagePixelRatio: pixelRatio,
        ),
  });
}

/// PNG of the live puck: halo, optional heading cone pointing up (the
/// marker's rotation turns it), and the go disc with a white ring.
Future<Uint8List> paintPuck(
  GoColors colors, {
  required bool heading,
  required double pixelRatio,
}) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder)..scale(pixelRatio);
  const centre = Offset(_coneTip, _coneTip);
  final halo = Paint()..color = colors.goHalo;

  canvas.drawCircle(centre, _dot + _halo, halo);
  if (heading) {
    canvas.drawPath(
      Path()
        ..moveTo(_coneTip, _coneTip - _coneTip)
        ..lineTo(_coneTip + _coneHalfWidth, _coneTip - _coneBase)
        ..lineTo(_coneTip - _coneHalfWidth, _coneTip - _coneBase)
        ..close(),
      halo,
    );
  }
  canvas
    ..drawCircle(
      centre.translate(0, 2),
      _dot,
      Paint()
        ..color =
            const Color(0x4D101828) // canvas: rgba(16,24,40,.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    )
    ..drawCircle(centre, _dot, Paint()..color = colors.puckRing)
    ..drawCircle(centre, _dot - _ring, Paint()..color = colors.go);

  final side = (puckSize * pixelRatio).round();
  final image = await recorder.endRecording().toImage(side, side);
  final png = await image.toByteData(format: ui.ImageByteFormat.png);
  image.dispose();
  return png!.buffer.asUint8List();
}
