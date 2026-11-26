import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ct_map.g.dart';

/// Both map styles (DESIGN §2.3), loaded together so a theme switch swaps
/// the style at once instead of flashing Google's default look.
@Riverpod(keepAlive: true)
Future<Map<Brightness, String>> mapStyles(Ref ref) async => {
  for (final b in Brightness.values)
    // The provider caches; the bundle's cache would hand later tests a
    // future tied to an earlier test's zone.
    b: await rootBundle.loadString('assets/map/${b.name}.json', cache: false),
};

/// Bangsar South, the start of the demo drive.
const _initialCamera = CameraPosition(
  target: LatLng(3.1110, 101.6655),
  zoom: 14,
);

/// Google map styled to the current theme. ctrlGo draws its own controls
/// and puck, so Google's are off.
class CtMap extends ConsumerWidget {
  const new({
    this.markers = const {},
    this.trafficEnabled = false,
    this.onMapCreated,
    super.key,
  });

  final Set<Marker> markers;
  final bool trafficEnabled;
  final MapCreatedCallback? onMapCreated;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styles = ref.watch(mapStylesProvider).value;
    if (styles == null) return ColoredBox(color: context.ctColors.ground);

    return GoogleMap(
      initialCameraPosition: _initialCamera,
      style: styles[Theme.of(context).brightness],
      markers: markers,
      trafficEnabled: trafficEnabled,
      onMapCreated: onMapCreated,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: false,
    );
  }
}
