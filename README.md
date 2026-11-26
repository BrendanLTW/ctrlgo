# ctrlGo

Navigation and temporary location sharing for the Klang Valley. A Flutter portfolio app in the ctrlWorks family (ctrlSpend, ctrlTask).

Docs: [`docs/PRD.md`](docs/PRD.md) · [`docs/PLAN.md`](docs/PLAN.md) · [`docs/DESIGN.md`](docs/DESIGN.md)

## Setup

Requires Flutter 3.47 (Dart 3.13).

```bash
flutter pub get
cp env.example.json env.json      # then paste your keys in; env.json is git-ignored
flutter run --dart-define-from-file=env.json
```

Without keys the app still runs; the map just stays blank.

### Google Maps Platform keys

ctrlGo uses one key per platform so each can be locked to that platform. In the [Google Cloud console](https://console.cloud.google.com/), in one project:

1. **Enable APIs:** Maps SDK for Android, Maps SDK for iOS, Maps JavaScript API, Places API (New), Routes API.
2. **Create three API keys** (APIs & Services › Credentials) and restrict each:

   | `env.json` name | Application restriction | API restriction |
   |---|---|---|
   | `MAPS_API_KEY_ANDROID` | Android apps: package `app.ctrlgo` + the SHA-1 of your debug and release signing certificates | Maps SDK for Android, Places API (New), Routes API |
   | `MAPS_API_KEY_IOS` | iOS apps: bundle ID `app.ctrlgo` | Maps SDK for iOS, Places API (New), Routes API |
   | `MAPS_API_KEY_WEB` | Websites: `http://localhost:*/*` and the GitHub Pages demo URL | Maps JavaScript API, Places API (New), Routes API |

   Get the debug SHA-1 with `cd android && ./gradlew signingReport`.
3. **Cap spending:** Billing › Budgets & alerts: a monthly budget with alerts at 50%, 90% and 100%. In APIs & Services › each API › Quotas, lower the per-day request limits for Places and Routes to what testing needs.

### How keys reach each platform

Keys are never committed. `flutter run/build --dart-define-from-file=env.json` passes them in at build time:

- **Dart:** `Env.mapsApiKey` (`lib/app/env.dart`) picks the current platform's key.
- **Android:** `android/app/build.gradle.kts` decodes Flutter's dart-defines into the `com.google.android.geo.API_KEY` manifest entry.
- **iOS:** `Info.plist` carries Flutter's `DART_DEFINES`; `AppDelegate.swift` decodes the key and calls `GMSServices.provideAPIKey`.
- **Web:** `lib/app/maps_loader_web.dart` adds the Maps JS script with the key before the app starts.

Before pushing, `tool/check_secrets.sh` fails if any tracked file contains a Google API key. CI runs it too.

## Checks

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
tool/check_secrets.sh
```
