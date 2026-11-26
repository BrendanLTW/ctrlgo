import 'package:ctrlgo/app/dependencies.dart';
import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/features/map/presentation/location_access_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_position.g.dart';

/// The user's latest fix, only while location access is granted (asking
/// the GPS without permission just errors).
@riverpod
Stream<GeoPosition> currentPosition(Ref ref) {
  final access = ref.watch(locationAccessControllerProvider).value;
  if (access == null || !access.granted) return const Stream.empty();
  return ref.watch(positionSourceProvider).positions;
}
