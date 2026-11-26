# ctrlGo (`ctrlgo`)

Navigation and temporary location-sharing app in Flutter for Android and iOS (no web build). Fourth app in the ctrlWorks family after ctrlSpend and ctrlTask. Portfolio project: architecture, tests and a downloadable APK matter as much as features.

## Read first
- `docs/PRD.md`: requirements FR-01–FR-29, user stories, data model, technical approach (§9). **The source of truth for behaviour.**
- `docs/PLAN.md`: the task list, in phases, each task with a "Done when". Work through it in order.
- `docs/DESIGN.md`: tokens, components, screens and the Flutter theme mapping. The [design canvas](https://claude.ai/artifact/RE5X66qRKwFtDys5JetR2q) linked there is **the source of truth for visuals**. If the PRD and the canvas disagree, follow the canvas and tell me.

## Scope
- **v1.0** = P0 + P1 (Phases 0–5). **Phase 6** = P2 stretch; build none of it until the v1.0 gate passes.
- Gates in PLAN.md are hard stops. Don't start the next phase until I confirm the gate.

## Stack
- Flutter stable (3.47), Dart 3.13, null safety
- State: Riverpod with code generation (`riverpod_annotation`, `riverpod_generator`)
- Navigation: go_router with `StatefulShellRoute` (Explore, Friends, Saved, Profile)
- Models: freezed + json_serializable
- Local storage: Drift (SQLite) for saved places, collections, recents, offline areas; shared_preferences for settings
- Maps and APIs: google_maps_flutter (JSON styles), Google Places API (New), Google Routes API
- Backend: Firebase (Auth, Firestore, Cloud Functions in TypeScript, FCM, App Check)
- Location: geolocator; Android foreground service for background sharing
- Voice: flutter_tts · Formatting: intl
- Testing: flutter_test, mocktail, integration_test, Firebase emulator suite
- Lints: very_good_analysis (same `analysis_options.yaml` as ctrlSpend)

Package versions follow ctrlSpend where the package is shared. Don't add packages not listed here or in PLAN.md without asking.

## Architecture
Feature-first, three layers per feature:

```
lib/
  app/                 # app widget, router, ThemeData, env
  core/                # shared widgets, theme tokens, extensions, Clock, result types
  features/
    map/  search/  routes/  navigation/  saved/  auth/  friends/
    sharing/  reports/  groups/  places/  safety/  offline/  settings/
      data/            # repository implementations, DTOs, API/Firestore/Drift sources
      domain/          # freezed entities, repository interfaces, pure logic
      presentation/    # screens, widgets, providers
  l10n/
functions/             # Cloud Functions (TypeScript) + rules tests
firestore.rules
test/ · integration_test/ · test_fixtures/   # recorded API responses
```

Layer rules:
- `domain/` is pure Dart: no Flutter, Firebase, Drift or Google SDK imports.
- Presentation never imports from `data/`; it reaches repositories only through providers.
- Time, position and connectivity are injected via `Clock`, `PositionSource` and `Connectivity`. Never call `DateTime.now()` or geolocator directly from domain or presentation code.
- Route progress, off-route detection, ETA, report expiry, share expiry and group status are pure functions with an injected clock.
- Screens are named after their canvas artboard (`RoutesScreen` for `Routes`, `LocDeniedScreen` for `LocDenied`).

## Non-negotiable conventions

**Theme**
- No hard-coded colours, font sizes, radii or spacing in widgets. Everything comes from DESIGN.md §2 via `ColorScheme`, the `CtTones` and `GoColors` theme extensions, `CtText`, `CtRadius` and `CtSpacing`.
- **Go blue means "you"**: only your position, your route and your sharing state. Buttons, selections and the nav use ink.
- Every screen works in light and dark.
- Poppins is bundled as an asset with tabular figures. No runtime font loading (golden tests and CI run offline).
- Touch targets ≥ 44 px, map buttons 48 px, anything used while driving ≥ 56 px.
- Icon-only buttons and map markers get semantic labels. Colour is never the only signal.
- All user-facing strings go in ARB files.

**Privacy and safety**
- Location is shared only while a share or group trip is active. Every share has server-enforced expiry.
- No ads and no third-party analytics or crash SDKs.
- No text input above 10 km/h unless the user confirms they're a passenger.

**Secrets**
- API keys live only in the git-ignored `env.json`, passed with `--dart-define-from-file=env.json` and read through `Env`. Never commit a key, a `google-services.json` with live keys, or a `.env`.

## Commands
Checks, run for every task:

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
tool/check_secrets.sh
firebase emulators:exec --only firestore,functions "npm --prefix functions test"   # from Phase 3
```

Other:
- Install: `flutter pub get`
- Codegen: `dart run build_runner build --delete-conflicting-outputs`
- Integration: `flutter test integration_test`
- Run: `flutter run --dart-define-from-file=env.json` (keys in the git-ignored `env.json`; see README › Setup)

## Testing
- Unit tests for every repository, calculation and state machine. Use fakes for `Clock`, `PositionSource` and `Connectivity`, an in-memory Drift database, and recorded fixtures in `test_fixtures/` instead of live API calls.
- A widget test for every screen, in light and dark.
- From Phase 3, every Firestore collection gets allow **and** deny rules tests (owner, audience, stranger, blocked user). No rule may use `if true`.

## Definition of done
A task is done only when:
1. Its "Done when" in `docs/PLAN.md` passes.
2. All checks above are green, with new tests for the new behaviour.
3. Codegen is up to date.
4. The task is ticked in `docs/PLAN.md`.
5. It's committed as a single Conventional Commit, e.g. `feat: theme tokens` (lowercase). Prefixes: `feat:`, `fix:`, `test:`, `refactor:`, `chore:` (setup, deps, CI), `docs:`.

## Working style
- One task per commit. Don't start the next task unprompted.
- If a task is blocked, write the blocker under it in `docs/PLAN.md` and stop. Don't skip ahead.
- If the PRD, PLAN, DESIGN or the canvas conflict, stop and ask rather than guess.
- Keep diffs small; don't refactor unrelated code.
- In each task summary, explain any non-obvious code (why, not just what) so I can explain it in an interview.
- If a package API is uncertain, check pub.dev rather than guessing.

## Git commits
Never add "Co-Authored-By", "Claude-Session", or "Generated with Claude Code" lines to commit messages or PR descriptions.
