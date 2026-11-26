# ctrlGo — Build Plan

Companion to [`docs/PRD.md`](PRD.md) and [`docs/DESIGN.md`](DESIGN.md). Code conventions live in `CLAUDE.md`.

## How to use this plan

- Work top to bottom. `/next` picks the first unchecked task, implements it, runs the checks, and ticks it off.
- Each task is one small PR or commit: code, tests, and a passing `flutter analyze` and `flutter test`.
- "Done when" is the acceptance test. If it can't be met, stop and write the blocker under the task rather than skipping ahead.
- FR and US IDs refer to the PRD; screen names refer to artboards on the [design canvas](https://claude.ai/artifact/RE5X66qRKwFtDys5JetR2q).
- Gates are hard stops: don't start the next phase until the gate passes.

**Checks run for every task**

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
firebase emulators:exec --only firestore,functions "npm --prefix functions test"   # from Phase 3
```

## Project structure

```
lib/
  app/                 # app widget, router, theme, env
  core/                # shared widgets, tokens, extensions, clock, result types
  features/
    map/               # map view, puck, markers, camera
    search/            # autocomplete, recents
    routes/            # route options, preferences, tolls, transit
    navigation/        # guidance engine, banner, voice, reroute
    saved/             # saved places, collections
    auth/              # sign-in, profile, username
    friends/           # requests, friendships, blocking
    sharing/           # shares, live positions, privacy
    reports/           # road reports
    groups/            # Go Together
    places/            # nearby, place detail
    safety/            # emergency, driving lock
    offline/           # offline areas, connectivity
    settings/
  l10n/
  each feature/: data/ (repositories, DTOs, sources) · domain/ (entities, pure logic) · presentation/ (screens, widgets, providers)
functions/             # Cloud Functions (TypeScript) + rules tests
firestore.rules
test/ · integration_test/ · test_fixtures/ (recorded API responses)
```

---

## Phase 0 — Setup (week 1)

- [x] **0.1 Create the Flutter project** with Android, iOS and web; package `app.ctrlgo`; strict `analysis_options.yaml` copied from ctrlSpend.
  Done when: `flutter analyze` is clean and the app runs on Android and web.
  Note: running on a device was skipped by choice (no Chrome or Android device on the dev machine); `flutter build apk --debug` and `flutter build web` succeed instead.
- [ ] **0.2 Add core dependencies**: riverpod (+ generator), go_router, freezed, json_serializable, drift, shared_preferences, intl, google_maps_flutter, geolocator, flutter_tts, firebase_core, mocktail.
  Done when: `build_runner` succeeds and the lockfile is committed.
- [ ] **0.3 Theme tokens** in `core/theme/`: `CtColors` (family core), `GoColors` extension (go, goSoft, altRoute, map colours), `CtTones` (8 tones × tile, fg, chart), `CtRadius`, `CtSpacing`, Poppins with tabular figures. Light and dark `ThemeData`. Values from DESIGN.md §2.
  Done when: a golden test renders a token swatch page in both themes.
- [ ] **0.4 App shell**: go_router `StatefulShellRoute` with Explore, Friends, Saved and Profile; `CtNavBar` floating pill plus contextual `CtFab`.
  Done when: a widget test switches tabs, each tab keeps its scroll position, and the FAB changes per tab.
- [ ] **0.5 Map styles**: `assets/map/light.json` and `dark.json` matching DESIGN.md §2.3; map switches style with the theme.
  Done when: toggling the theme on the demo screen changes the map style.
- [ ] **0.6 Environment and keys**: `--dart-define` for API keys; keys restricted by package, SHA-1 and web referrer; budget alerts on the Maps project.
  Done when: no key is in git (CI grep check), and the README documents the setup.
- [ ] **0.7 Abstractions for testability**: `Clock`, `PositionSource` (real, simulated, recorded), `Connectivity`. The web demo uses `SimulatedPositionSource` replaying a GPX file of the Bangsar South → KLCC drive.
  Done when: a unit test drives a fake position stream through 10 points.
- [ ] **0.8 CI**: GitHub Actions running format, analyze and test on push; web build deployed to GitHub Pages on main.
  Done when: the badge is green and the demo URL loads the themed shell.

## Phase 1 — Map, search, saved, routes (weeks 2–3)

- [ ] **1.1 Location permission flow** (FR-10): explainer → system prompt → states for Always, While using and Denied; the `LocDenied` screen.
  Done when: widget tests cover all three states and "Open Settings" deep-links on Android.
- [ ] **1.2 Explore map** (FR-01): full-screen map, `LocationPuck` with heading cone, recentre button, layers button, floating search, quick-destination chips.
  Done when: the puck follows the simulated position and recentre animates back to it.
- [ ] **1.3 Places autocomplete** (FR-02): repository using session tokens and location bias; 250 ms debounce; highlighted matches.
  Done when: unit tests cover debounce and session-token reuse; the `Search` screen widget test shows highlighted results from fixtures.
- [ ] **1.4 Recents and search empty state**: Drift table capped at 50; Clear; the `SearchEmpty` screen with suggestions and "Drop a pin".
  Done when: a repository test proves the cap and the order.
- [ ] **1.5 Saved places** (FR-05): Drift tables; Home and Work cards with live travel time; favourites list; Edit mode with delete and Undo; `PlaceEdit` with name, kind, colour and map preview.
  Done when: tests cover the single-Home rule, delete with Undo restoring the same id, and travel time refreshing on resume.
- [ ] **1.6 Routes repository** (FR-03): Routes API for car and walk, up to 3 alternatives, polyline decode, traffic intervals, 60 s cache.
  Done when: unit tests parse fixtures into `RouteOption` entities with traffic segments.
- [ ] **1.7 Route selection screen**: header with from/to and swap; ETA bubbles; selected route on top; `RouteOptionCard` list; mode selector; Start and Share ETA.
  Done when: tapping a bubble or card selects the route (widget test), and the `RoutesLoading` and `NoRoute` states render from a fake repository.
- [ ] **1.8 Integration test**: search "klcc" → pick Suria KLCC → routes shown → select the second route.
  Done when: it passes in CI on the web target with fixtures.

## Phase 2 — Navigation (weeks 4–5)

- [ ] **2.1 Guidance engine (pure Dart)**: snap the position to the route, distance to the next manoeuvre, remaining distance and ETA, arrival detection.
  Done when: unit tests replay the recorded drive and assert the banner states at 10 checkpoints.
- [ ] **2.2 Navigation screen** (FR-04): `TurnBanner`, "Then" strip, `NavPanel` with ETA, End, speed and limit.
  Done when: golden tests for light and dark; End returns to Explore.
- [ ] **2.3 Voice guidance** (FR-15): TTS at 500 m, 200 m and at the turn; mute toggle that persists.
  Done when: a unit test with a fake TTS asserts the phrases and timing.
- [ ] **2.4 Lanes and speed** (FR-15): lane hints from route data; limit sign; speeding state when the limit is exceeded by more than 5 km/h for 3 s.
  Done when: unit tests cover hysteresis (no flicker around the limit).
- [ ] **2.5 Rerouting** (FR-16): off-route after 50 m for 5 s → fetch → "New route · +n min" card; the `NavReroute` screen.
  Done when: a replay with a missed turn triggers exactly one reroute.
- [ ] **2.6 Arrival** (`Arrived` screen): summary stats, parking nearby, Save place, Done.
  Done when: arrival is detected within 30 m of the destination in the replay.
- [ ] **Gate — MVP:** a passenger-run drive test (Bangsar South → KLCC) completes with no crash, at most one wrong instruction, and an ETA error under 3 minutes. Record the result in `docs/TESTING.md`.

## Phase 3 — Accounts, friends, sharing (weeks 6–7)

- [ ] **3.1 Firebase setup**: Auth (Google, Apple), Firestore, Functions (TypeScript), FCM, App Check; emulator config; the rules test harness in `functions/test`.
  Done when: `emulators:exec` runs an empty rules suite in CI.
- [ ] **3.2 Sign-in and username** (FR-06): unique lowercase username reserved in a transaction.
  Done when: rules tests show a username can't be taken twice and a profile can't be edited by another user.
- [ ] **3.3 Friend requests** (FR-07): send by username, QR code or invite link; accept or decline; remove; block.
  Done when: rules tests cover each allow and deny case, including blocked users being unable to send requests; widget tests cover `Friends`, `AddFriend` and `FriendsEmpty`.
- [ ] **3.4 Shares** (FR-08): `ShareSheet` with duration, mode and audience; writes a `Share`; Cloud Function deletes expired shares every minute and on arrival.
  Done when: a unit test of expiry with a fake clock, and a function test proves an expired share is deleted and readers lose access.
- [ ] **3.5 Live positions**: publisher throttled by battery mode (Balanced default) with an Android foreground service; reader streams friends' positions.
  Done when: rules tests prove a non-audience user can't read a position; a widget test shows a stale friend faded with its age.
- [ ] **3.6 Live map** (FR-09, `LiveMap` screen): friend pins, selection sheet with distance, ETA, battery and update age, Notify me.
  Done when: selecting a pin updates the sheet (widget test).
- [ ] **3.7 Sharing feedback**: green banner on Friends, the live map and navigation; Stop with Undo; "Sharing stopped" toast.
  Done when: an integration test shares, sees the banner, stops, undoes, and stops again.
- [ ] **3.8 Privacy screen** (FR-10, `Privacy`): per-person switches, Stop all, permission radio with explanation, history off, delete recents.
  Done when: Stop all removes every active share in the emulator.
- [ ] **3.9 Share ETA from navigation** (FR-17): auto-stop on arrival; the arrival screen says so.
  Done when: the drive replay ends the share at arrival.
- [ ] **Gate — Security:** every collection has rules tests for owner, audience, stranger and blocked user. No rule uses `allow read, write: if true`.

## Phase 4 — Transit, modes, places (weeks 8–9)

- [ ] **4.1 Motorcycle mode and preferences** (FR-12, `RoutePrefs`): two-wheeler routes (or the fallback decided in the PRD open questions), avoid tolls, highways and ferries, toll estimate.
  Done when: fixtures show avoidTolls changing the toll total to RM 0.00.
- [ ] **4.2 Transit routes** (FR-13, `RoutesTransit`): options with legs, fare and departure–arrival times.
  Done when: fixtures for LRT-only, bus + LRT and KTM + LRT parse into leg chips.
- [ ] **4.3 Transit steps** (`TransitDetail`): timeline with platforms, interchange walking time, step-free note, exits, live next departures.
  Done when: a widget test renders all five step types.
- [ ] **4.4 Disruptions** (FR-14): banner per affected line, with last-updated time; hidden when the source is unavailable.
  Done when: a stale feed shows "updated 45 min ago" rather than pretending to be live.
- [ ] **4.5 Search along route** (FR-19, `AlongRoute`): categories, detour minutes, national fuel prices from data.gov.my, parking.
  Done when: results are sorted by detour; prices show the week they apply to.
- [ ] **4.6 Multi-stop** (FR-20, `MultiStop`): up to 5 stops, reorder, remove, totals.
  Done when: a unit test of total time and arrival with stop durations.
- [ ] **4.7 Nearby and place detail** (FR-21, `Nearby`, `Place`): categories, filters, rating, hours (expandable), contact, photos with attribution.
  Done when: closing-soon logic is unit-tested across midnight.

## Phase 5 — Reports, safety, polish (week 10)

- [ ] **5.1 Report sheet** (FR-18, `ReportSheet`): 8 types, one tap, Undo 5 s; rate limit of 1 report per 30 s per user.
  Done when: function tests cover the rate limit.
- [ ] **5.2 Reports on the route and alerts** (`HazardAlert`): markers, alert at 800 m, Still there / Not there, expiry bar.
  Done when: unit tests cover expiry extension and removal after 3 net dismissals; Firestore TTL is configured.
- [ ] **5.3 Emergency** (FR-22, `Emergency`): 999 with a 3-second cancel, share with emergency contacts, SMS fallback.
  Done when: a widget test proves cancel stops the call intent.
- [ ] **5.4 Driving lock** (FR-23, `DriveLock`): text fields disabled above 10 km/h; voice search; "I'm a passenger" for the trip.
  Done when: a unit test with a speed stream covers hysteresis (lock at 10, unlock below 5 for 10 s).
- [ ] **5.5 Accessibility pass**: semantics on map markers and icon buttons, 200% text scale, contrast check in both themes.
  Done when: `meetsGuideline` checks pass in widget tests for every screen.
- [ ] **5.6 README and demo**: GIF of the simulated drive, architecture diagram, decision notes (Google vs Mapbox, Firestore rules, guidance engine).
  Done when: a reviewer can run the demo in one click.
- [ ] **Gate — v1.0:** every P0 and P1 FR is ticked, CI is green, the web demo and APK are published.

## Phase 6 — Stretch (pick at least two)

- [ ] **6.1 Go Together** (FR-24, `Groups`, `GroupCreate`, `GroupMap`): groups, private invite links with approval, shared map, member status, arrival notifications, leave or end.
- [ ] **6.2 Offline areas** (FR-25, `OfflineMaps`): spike Mapbox or MapLibre first; download, update, delete, storage bar.
- [ ] **6.3 GPS and connection loss** (FR-26, `GpsLost`): dead reckoning, grey estimated puck, stale labels, recovery toast.
- [ ] **6.4 Collections** (FR-27): create, add from place detail, filter Saved by collection.
- [ ] **6.5 Battery modes** (FR-28): Real time, Balanced, Saver, with measured battery cost in `docs/TESTING.md`.
- [ ] **6.6 Bahasa Melayu** (FR-29): full ARB translation, reviewed by a native speaker.
