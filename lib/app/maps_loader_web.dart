import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Adds the Maps JS API script with [apiKey] and waits for it to load.
/// Done in Dart because `index.html` can't read `--dart-define` values.
Future<void> loadMapsScript(String apiKey) {
  final loaded = Completer<void>();
  final script = web.HTMLScriptElement()
    ..src =
        'https://maps.googleapis.com/maps/api/js'
        '?key=${Uri.encodeQueryComponent(apiKey)}&loading=async'
    ..async = true
    ..onload = ((web.Event _) => loaded.complete()).toJS
    ..onerror = ((web.Event _) => loaded.completeError(
      StateError('Google Maps script failed to load'),
    )).toJS;
  web.document.head!.append(script);
  return loaded.future;
}
