import 'package:flutter/foundation.dart';

/// Build-time settings from `--dart-define-from-file=env.json` (README ›
/// Setup). Never commit a key: `tool/check_secrets.sh` fails if one is
/// tracked.
abstract final class Env {
  // One key per platform, each restricted to that platform in Google Cloud.
  static const _mapsKeyAndroid = String.fromEnvironment('MAPS_API_KEY_ANDROID');
  static const _mapsKeyIos = String.fromEnvironment('MAPS_API_KEY_IOS');

  /// Google Maps Platform key for the platform we're running on. Empty when
  /// none was passed.
  static String get mapsApiKey => defaultTargetPlatform == TargetPlatform.iOS
      ? _mapsKeyIos
      : _mapsKeyAndroid;
}
