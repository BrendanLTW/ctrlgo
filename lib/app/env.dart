import 'package:flutter/foundation.dart';

/// Build-time settings from `--dart-define-from-file=env.json` (README ›
/// Setup). Never commit a key: `tool/check_secrets.sh` fails if one is
/// tracked.
abstract final class Env {
  // One key per platform, each restricted to that platform in Google Cloud.
  static const _mapsKeyAndroid = String.fromEnvironment('MAPS_API_KEY_ANDROID');
  static const _mapsKeyIos = String.fromEnvironment('MAPS_API_KEY_IOS');

  /// SHA-1 of the signing certificate, so REST calls (Places, Routes) pass
  /// the Android app restriction. Not secret, but it differs per keystore.
  static const _androidCertSha1 = String.fromEnvironment(
    'MAPS_ANDROID_CERT_SHA1',
  );

  static const packageName = 'app.ctrlgo';

  static bool get _ios => defaultTargetPlatform == TargetPlatform.iOS;

  /// Google Maps Platform key for the platform we're running on. Empty when
  /// none was passed.
  static String get mapsApiKey => _ios ? _mapsKeyIos : _mapsKeyAndroid;

  /// Headers a platform-restricted key needs on REST calls. The native Maps
  /// SDKs add these themselves; plain HTTP doesn't.
  static Map<String, String> get mapsAppHeaders => _ios
      ? const {'X-Ios-Bundle-Identifier': packageName}
      : const {
          'X-Android-Package': packageName,
          'X-Android-Cert': _androidCertSha1,
        };
}
