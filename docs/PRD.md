# ctrlGo — Product Requirements Document

2026-11-25 · Brendan · Status: draft v1

Related: [`docs/PLAN.md`](PLAN.md) (build phases) · [`docs/DESIGN.md`](DESIGN.md) (design system and screens) · `CLAUDE.md` (code conventions) · [Design canvas](https://claude.ai/artifact/RE5X66qRKwFtDys5JetR2q)

---

## 1. Overview

ctrlGo is a mobile navigation and location-sharing app for people getting around the Klang Valley. It combines turn-by-turn directions for car, motorcycle, walking and public transport with temporary, privacy-first location sharing between friends and small groups. It is the fourth app in the ctrlWorks family (ctrlSpend, ctrlTask, ctrlStock) and shares their design system.

Like ctrlSpend, it is a Flutter portfolio project, so architecture, tests and a live demo are first-class requirements alongside the user experience.

**Problem.** Malaysians already use two or three apps for one trip: one for directions, one for live traffic and police reports, another to check the LRT, and WhatsApp to send "otw, 10 min" with a live location that never really ends. Sharing a location is all-or-nothing, it often runs longer than intended, and there's no single view of "where is everyone and when will they get here?"

**Vision.** One map-first app answers three questions quickly: how do I get there, what's on the road, and where are my people? Sharing always has an end time, is visible while it's on, and stops with one tap.

## 2. Goals and non-goals

**Product goals**

- Get from opening the app to a started route in 15 seconds or less for a saved place.
- Show multiple route options with traffic-aware ETAs for car, motorcycle, walking and public transport.
- Let users share their live location with chosen friends for a fixed time, and stop with one tap.
- Show the community's road reports (accidents, jams, police, floods) on the route, with timestamps and automatic expiry.
- Let a small group head to one destination and see everyone's ETA (Go Together).

**Portfolio goals**

- Feature-first Flutter architecture with enforced layer boundaries, reused from ctrlSpend.
- A real backend with security rules that are tested, not just written.
- Location, background and real-time code that is testable through injected clocks, position streams and fakes.
- CI on every push, a web demo with simulated GPS, and an Android APK.

**Non-goals for v1**

- Building a routing engine or map renderer. ctrlGo uses third-party map, places and routing APIs.
- Its own reviews and ratings. Place ratings come from the places provider.
- Ride-hailing, payments, toll top-ups or parking payments.
- Car head units (Android Auto, CarPlay) and smartwatches.
- Coverage outside Malaysia. Other countries may work but aren't tested.
- Monetisation.

## 3. Target users

| Persona | Context | Needs | Frustrations today |
|---|---|---|---|
| Aisyah, 27, marketing executive | Drives Bangsar South ↔ KLCC daily; meets friends after work | Fastest route with honest ETAs; tell friends when she'll arrive | Switching between Waze and WhatsApp live location; forgetting to stop sharing |
| Wei Jie, 24, engineer, car-free | LRT and e-hailing; walks the last kilometre | Transit routes with interchanges, delays and walking legs | Transit apps that don't show disruptions or exits |
| Hafiz, 30, delivery rider on the side | Motorcycle around the city | Motorcycle-friendly routes, police and pothole reports, petrol stops | Car routes that send bikes onto expressways |
| Priya, 35, parent | Coordinates family trips and school runs | Group trips, arrival alerts, emergency shortcuts | Calling everyone to ask "where are you now?" |

**Secondary audience:** recruiters and engineers reviewing the portfolio. They'll open the web demo (simulated GPS, seeded friends) and read the README and a few source files.

## 4. User stories and acceptance criteria

Each criterion is testable as written and doubles as a test case. Story IDs map to the functional requirements in section 5.

### Navigation

**US-1 Find a place.** As a user, I want to search for a place or address and see suggestions as I type.
- Autocomplete results appear within 300 ms of typing pausing, biased to the user's location.
- Results show name, type, area and distance; matched text is highlighted.
- Recent searches and saved places show before the user types.
- No results shows the "No places match that" state with suggestions and a "Drop a pin" option.

**US-2 Choose a route.** As a user, I want to compare routes before I go.
- Up to three routes, each with ETA, distance, a traffic summary and a "Fastest" or "+n min" tag.
- Tapping a route card or its ETA bubble on the map selects it; the selected route draws on top in Go blue.
- Switching mode (car, motorcycle, walk, transit) refetches routes for that mode.
- While loading, skeleton cards and a progress bar show; if offline, the error state offers retry.

**US-3 Turn-by-turn navigation.** As a driver, I want clear instructions I can follow without reading much.
- The turn banner shows distance, manoeuvre arrow, street name, lane guidance, and the following turn.
- Voice guidance speaks each manoeuvre; it can be muted from the map with one tap.
- The speedometer turns red and shows "Slow down" when speed exceeds the limit by more than 5 km/h.
- If the user leaves the route by more than 50 m for 5 s, a new route is fetched and announced ("New route · +2 min").
- If GPS is lost, the position is estimated, shown in grey, and the ETA is marked as an estimate.

**US-4 Plan a trip with stops.** As a user, I want to add stops along the way.
- Up to 5 stops; stops can be reordered and removed; totals update live.
- "Search along route" lists petrol, food, parking and coffee sorted by detour time.

**US-5 Set route preferences.** As a user, I want to avoid tolls, highways or ferries.
- Preferences apply to all new routes and are shown as a chip on the route sheet.
- Each route shows an estimated toll total; avoiding tolls shows RM 0.00.
- Motorcycle mode never routes onto roads that ban motorcycles.

**US-6 Take public transport.** As a car-free user, I want transit routes I can trust.
- Each option shows departure–arrival time, legs (walk, LRT, MRT, KTM, bus) and fare.
- Step view shows platforms, interchanges (with walking time and step-free info), exits and live next departures.
- Service disruptions on a line in the route show a banner with when it was last updated.

### Community road reports

**US-7 Report what's on the road.** As a driver, I want to report something in one tap without typing.
- Report types: accident, traffic jam, police, speed camera, pothole, road closed, flood, hazard.
- Reporting takes at most 2 taps from navigation, or a voice command; typing is never required.
- A confirmation with Undo shows for 5 seconds.

**US-8 See and confirm reports.** As a driver, I want to know what's ahead and help keep it accurate.
- Reports on the route show on the map; an alert appears 800 m before (car) or 300 m before (walk).
- Each report shows its age, the number of confirmations, and when it expires.
- "Still there" extends the expiry; enough "Not there" votes remove it.
- Reports expire on their own (default 30 min for jams and police, 2 h for closures and floods).

### Friends and live location

**US-9 Add and manage friends.** As a user, I want to connect with people I trust.
- Add by username, phone contact, QR code or invite link; requests must be accepted.
- Friends can be removed or blocked. Blocking hides you from search, sharing and groups, without notifying them.

**US-10 Share my location temporarily.** As a user, I want to share where I am for a set time.
- Duration options: 15 min, 1 hour, until a time today, or until I stop (with a 24 h reminder).
- The user chooses live location or ETA only, and which friends see it.
- While sharing, a green pulse banner is visible on Friends, the live map and navigation.
- Sharing stops with one tap from Friends, Privacy or navigation, with Undo.
- ETA sharing ends automatically on arrival, and the arrival screen says so.

**US-11 See friends.** As a user, I want to see where my friends are and how far away.
- Friends who share appear on the map with their initial and colour; selecting one shows place, distance, ETA, battery and last update.
- A location older than 10 minutes appears faded with its age ("12 min ago").
- "Notify me" alerts the user when that friend arrives somewhere they share.

### Go Together

**US-12 Create a group trip.** As an organiser, I want to bring people to one place.
- A group has a name, a meeting point, an arrive-by time and members.
- Invites go by contact or a private link; the organiser approves who joins.
- Sharing inside the group ends when the last person arrives or at a set end time.

**US-13 Travel together.** As a member, I want to see everyone's progress.
- A shared map shows all members with ETA, distance and status (driving, on LRT, arrived, delayed).
- Everyone gets a notification when someone arrives.
- Members can leave; the organiser can end the trip for everyone.

### Places and saved

**US-14 Discover nearby places.** As a user, I want to find food and services around me.
- Categories: food, cafés, attractions, services; filters: open now, rating, distance, price.
- Place detail shows photos, rating and reviews summary, hours (expandable), address, phone and website.

**US-15 Save places.** As a user, I want quick access to places I go often.
- Home and Work shortcuts show the current travel time.
- Places can be saved, renamed, given an icon colour, put in custom collections, edited and deleted (with Undo).

### Offline, safety and settings

**US-16 Use ctrlGo with a bad connection.** As a user, I want the app to keep working when the signal drops.
- Users can download map areas, see their size and storage use, and update or delete them.
- Offline, saved places, recent searches and an active route keep working; live data shows its age.
- When the connection comes back, the app says so and refreshes the route.

**US-17 Stay safe.** As a user, I want help in an emergency and fewer distractions while driving.
- Emergency screen: call 999 with a 3-second cancel, share live location with emergency contacts, and send location by SMS.
- Typing is disabled above 10 km/h unless the user confirms they're a passenger; voice and one-tap shortcuts remain.

**US-18 Control my privacy.** As a user, I want to know and control who can see me.
- Privacy screen lists everyone who can see the user, with per-person switches and "Stop all".
- Location permission states (Always, While using, Never) each explain what works and what doesn't.
- Location history is off by default; recent searches can be deleted.

**US-19 Personalise.** Theme (light, dark, system), map style, distance units, language (English, Bahasa Melayu), default travel mode, voice guidance, and how often location updates while sharing.

## 5. Functional requirements

P0 is the minimum shippable app, P1 completes the public launch, P2 holds stretch features. P2 starts only after P0 and P1 are green and deployed.

| ID | Requirement | Story | Priority |
|---|---|---|---|
| FR-01 | Map home with current location, floating search, quick destinations, mode selector | US-1 | P0 |
| FR-02 | Place search with autocomplete, recents and saved places | US-1 | P0 |
| FR-03 | Route options for car and walking with traffic-aware ETA | US-2 | P0 |
| FR-04 | Turn-by-turn navigation: banner, next turn, ETA panel, end trip | US-3 | P0 |
| FR-05 | Saved places: Home, Work, favourites; add, edit, delete with Undo | US-15 | P0 |
| FR-06 | Account (Google or phone sign-in), profile and username | US-9 | P0 |
| FR-07 | Friends: request, accept, remove, block | US-9 | P0 |
| FR-08 | Temporary live sharing with duration, audience and one-tap stop | US-10 | P0 |
| FR-09 | Friends on the map with distance, ETA and last-update age | US-11 | P0 |
| FR-10 | Privacy screen and location permission flows, including the denied state | US-18 | P0 |
| FR-11 | Light and dark themes; loading, empty, error and offline states for every screen | All | P0 |
| FR-12 | Motorcycle mode and route preferences (avoid tolls, highways, ferries), toll estimate | US-5 | P1 |
| FR-13 | Public transport routes, step view, interchanges, live departures | US-6 | P1 |
| FR-14 | Service disruption banners on transit lines | US-6 | P1 |
| FR-15 | Voice guidance, lane guidance, speed limit and speeding alert | US-3 | P1 |
| FR-16 | Automatic rerouting on missed turns | US-3 | P1 |
| FR-17 | Share trip ETA from navigation; auto-stop on arrival | US-10 | P1 |
| FR-18 | Road reports: create, show on route, alert, confirm or dismiss, expire | US-7, US-8 | P1 |
| FR-19 | Search along route (petrol, food, parking, coffee) with detour time | US-4 | P1 |
| FR-20 | Multi-stop journeys (up to 5 stops) | US-4 | P1 |
| FR-21 | Nearby discovery and place detail (hours, contact, photos, rating) | US-14 | P1 |
| FR-22 | Emergency screen and emergency contacts | US-17 | P1 |
| FR-23 | Driving lock: no typing above 10 km/h unless passenger | US-17 | P1 |
| FR-24 | Go Together: create group, private invite, shared map, member ETAs, arrival alerts, leave or end | US-12, US-13 | P2 |
| FR-25 | Offline map areas: download, update, delete, storage use | US-16 | P2 |
| FR-26 | GPS and connection loss handling with estimated position and stale-data labels | US-16 | P2 |
| FR-27 | Custom collections for saved places | US-15 | P2 |
| FR-28 | Battery modes for background sharing (real time, balanced, saver) | US-19 | P2 |
| FR-29 | Bahasa Melayu translation | US-19 | P2 |

FR-26 is P2 as a dedicated experience, but basic stale-data labels ("updated 12 min ago") are part of FR-09 and FR-11 in P0.

## 6. Non-functional requirements

| Area | Requirement |
|---|---|
| Performance | Cold start to an interactive map in under 2.5 s on a mid-range Android device; map pans at 60 fps; route options shown within 2 s on 4G |
| Location accuracy | Navigation uses high-accuracy updates at 1 Hz; sharing uses the battery mode setting, defaulting to Balanced (every 30 s while moving, paused when still) |
| Battery | Balanced sharing uses no more than 3% battery an hour on a reference device; background work uses a foreground service on Android with a visible notification |
| Real time | A friend's location change appears on others' maps within 5 s in Real-time mode |
| Privacy | Location is shared only while a share or group trip is active; history is off by default; shares and reports have server-enforced expiry; no ads, no third-party analytics SDKs |
| Security | Every read and write is guarded by backend security rules, with rule tests in CI; App Check on all backend calls; API keys restricted by app signature and referrer |
| Safety | No text input while moving above 10 km/h; alerts are voice plus large tap targets (at least 56 px) |
| Offline | Saved places, recents and the active route survive loss of connection; live data always shows its age |
| Accessibility | Semantic labels on all icon-only controls and map markers; WCAG AA contrast in both themes; layouts hold at 200% text scale; colour never the only signal |
| Localisation | All strings in ARB files; English at launch, Bahasa Melayu in P2; distance in km/m by default |
| Platforms | Android and iOS primary; a web build for the portfolio demo with simulated GPS and seeded friends (background location, voice and notifications hidden on web) |
| Quality | `flutter analyze` clean with strict lints; unit tests for every repository, calculation and state machine; widget tests for every screen; integration tests for the core flows; CI on every push |

## 7. Data model

The backend holds accounts, the social graph, active shares and reports. Saved places, recents and offline areas stay on the device.

| Entity | Where | Fields | Rules |
|---|---|---|---|
| User | Backend | id, displayName, username, photoUrl?, createdAt | Username unique, lowercase, 3–20 chars |
| FriendRequest | Backend | id, fromId, toId, status (pending / accepted / declined), createdAt | One open request per pair |
| Friendship | Backend | pairId (sorted ids), userIds[2], createdAt, emergency flags per side | Created only from an accepted request |
| Block | Backend | blockerId, blockedId, createdAt | Blocked users can't find, request, see or group with the blocker |
| Share | Backend | id, ownerId, audienceIds[], mode (live / eta), startsAt, expiresAt?, destination?, active | expiresAt required unless "until I stop"; server deletes expired shares |
| LivePosition | Backend | ownerId, lat, lng, accuracyM, heading?, speedKmh?, battery?, updatedAt | Readable only by members of an active share or group the owner is in |
| Group | Backend | id, name, ownerId, memberIds[], destination, arriveBy, endsAt, inviteCode, status | Members only; invite code needs owner approval |
| Report | Backend | id, type, lat, lng, heading?, createdBy, createdAt, expiresAt, confirms, dismissals | TTL deletes after expiresAt; one vote per user per report |
| SavedPlace | Device | id, name, placeId?, lat, lng, kind (home / work / favourite / custom), colour, collectionIds[] | One Home and one Work |
| Collection | Device | id, name, colour | Name unique |
| RecentSearch | Device | id, query or placeId, label, searchedAt | Keep the latest 50 |
| OfflineArea | Device | id, name, bounds, sizeBytes, downloadedAt, version | Updates on Wi-Fi only by default |

Preferences (theme, units, language, default mode, avoid flags, voice, battery mode) are stored as key-value preferences on the device.

## 8. UX: screens and key flows

Full screen inventory, components and tokens: [`docs/DESIGN.md`](DESIGN.md). Every screen has light and dark versions on the [design canvas](https://claude.ai/artifact/RE5X66qRKwFtDys5JetR2q).

Navigation uses four tabs: **Explore** (map, search, routes, navigation), **Friends** (People and Groups), **Saved**, **Profile**. The round button next to the tab bar is that tab's primary action: directions, share location, or add a place.

**Key flows**

1. First launch: sign in → choose username → location permission explainer → map centred on the user.
2. Go somewhere: search → pick a place → compare routes → Start → navigate → arrive (sharing ends automatically).
3. Share location: Friends → share button → duration, mode and people → share → green banner until it ends or is stopped.
4. Report on the road: during navigation tap Report → pick a type → Undo for 5 s.
5. Go Together: Friends → Groups → New group → meeting point, time, members → start → shared map → arrival alerts.
6. Lose signal: banner and grey estimated position → connection returns → "route updated" message.

**Design principles:** the map is the main surface, primary actions sit in the bottom 40% of the screen, blue means "you" and nothing else, sharing is always visible and always ends, and nothing needs typing while driving.

## 9. Technical approach

ctrlGo reuses ctrlSpend's feature-first structure and conventions (`CLAUDE.md`). The task breakdown lives in [`docs/PLAN.md`](PLAN.md).

| Concern | Choice | Reason |
|---|---|---|
| App framework | Flutter (stable), Dart 3 | Same as the rest of ctrlWorks |
| State management | Riverpod with code generation | Testable providers; streams for location and real-time data |
| Navigation | go_router with `StatefulShellRoute` | Four tabs that keep their state, plus deep links for invites (`ctrlgo.app/g/<code>`) |
| Models | freezed + json_serializable | Immutable entities shared by the app and the backend |
| Map display | `google_maps_flutter` with JSON map styles (light and dark) | Mature SDK; styles match the design tokens |
| Places | Google Places API (New): autocomplete, details, photos, nearby | Ratings, hours and photos without building a places database |
| Routing | Google Routes API: traffic-aware car, two-wheeler, walk, transit; waypoints; avoid tolls, highways, ferries; toll info | One provider for all modes and preferences |
| Transit disruptions | Malaysian open data (data.gov.my GTFS feeds) for live positions; alert source to confirm | Fills the gap for line-level disruptions |
| Fuel prices | data.gov.my weekly fuel price data | Malaysian pump prices are set nationally each week |
| Backend | Firebase: Auth, Firestore, Cloud Functions, Cloud Messaging, App Check | Real-time listeners, TTL deletion, security rules with an emulator for tests |
| Location | `geolocator` for foreground; a foreground-service plugin for background sharing on Android | Background location must be visible and stoppable |
| Local storage | Drift (SQLite) for saved places, collections, recents, offline area metadata; shared_preferences for settings | Same as ctrlSpend; works offline |
| Voice | `flutter_tts` | On-device speech for guidance |
| Testing | flutter_test, mocktail, integration_test, Firebase emulator suite, fake position streams and clock | Navigation and sharing logic is deterministic in tests |
| CI/CD | GitHub Actions | Analyze, test and rules tests on push; web demo to GitHub Pages; APK on release |

**Layer rules:** presentation talks only to repository interfaces through providers. The domain layer is pure Dart, with no Flutter, Firebase or Google SDK imports. Route progress, off-route detection, ETA, report expiry, share expiry and group status are pure functions with an injected clock, so they can be unit-tested without a device.

**Cloud Functions:** expire shares and groups, compute report confidence and expiry, send arrival and group notifications, and enforce blocking on the server.

**Cost control:** Places autocomplete uses session tokens; route requests are debounced and cached per origin, destination and mode for 60 s; the web demo uses recorded fixtures instead of live API calls.

## 10. Success metrics

As with ctrlSpend, there's no third-party analytics. Success is measured through usability tests with 5 people, a timed drive test, and repo signals.

| Metric | Target | How it's measured |
|---|---|---|
| Time to start navigation to a saved place | ≤ 15 s from launch | Timed task in usability tests |
| Share-and-stop success | 5 of 5 testers start a 1-hour share and stop it unaided | Usability tests |
| "Who can see me?" | Testers answer correctly within 10 s | Usability tests |
| Report while driving | Report made in ≤ 2 taps, under 3 s | Passenger-run drive test |
| Battery cost of sharing | ≤ 3% an hour in Balanced mode | 2-hour test on a reference device |
| Test coverage | ≥ 80% of domain and data layers; every security rule has an allow and a deny test | Coverage report and emulator tests in CI |
| Build health | Green CI on main; zero analyzer warnings | GitHub Actions badge |
| Demo reach | Web demo with simulated drive opens in under 3 s on desktop | Lighthouse on the GitHub Pages build |

## 11. Milestones and release plan

About ten part-time weeks to v1.0 (P0 + P1). Each phase maps to a section of [`docs/PLAN.md`](PLAN.md), so Claude Code can work through it with `/next`.

| Phase | Scope | Weeks | Gate |
|---|---|---|---|
| 0 | Setup: repo, CI, theme tokens, API keys, Firebase emulator, web demo spike | 1 | CI green; themed empty app on web and Android |
| 1 | Map, search, saved places, car and walking routes | 2 | — |
| 2 | Navigation: turn-by-turn, voice, lanes, speed, rerouting | 2 | **MVP gate:** drive test passes |
| 3 | Accounts, friends, live sharing, privacy | 2 | Security rules fully tested |
| 4 | Transit, motorcycle, preferences, along-route, multi-stop, places | 2 | — |
| 5 | Road reports, emergency, driving lock, polish | 1 | **v1.0 gate:** all P0 and P1 green; demo deployed |
| 6 | Stretch: Go Together, offline areas, GPS loss, collections, battery modes, Bahasa Melayu | open | Pick at least two |

If time runs short, cut Phase 6 entirely; v1.0 is complete without it.

## 12. Risks and open questions

The biggest risks are API cost and the complexity of background location, not the UI.

| Risk | Impact | Mitigation |
|---|---|---|
| Google Maps Platform costs from search and routes during testing | Unexpected bill | Budget alerts and quotas; session tokens; caching; fixtures for the web demo and tests |
| Background location restrictions (Android 14+, iOS) | Sharing stops when the app is closed | Foreground service with a visible notification; "Always" permission explained in-app; graceful "last seen" fallback |
| Privacy bugs in sharing rules | Someone sees a location they shouldn't | Rules tested in the emulator in CI; server-side expiry; blocking enforced in rules and functions |
| Report spam or false reports | Untrustworthy map | Rate limit per user; confidence from confirmations; short default expiry |
| Navigation accuracy in KL tunnels and stacked roads | Wrong turns, bad reroutes | Off-route needs 50 m for 5 s; dead reckoning shown as an estimate |
| Offline maps with Google Maps SDK | No supported offline tiles | Phase 6 spike: evaluate Mapbox or MapLibre for offline areas before committing |
| AI-generated code you can't explain | Weak interview answers | Review every diff; ask Claude Code to explain anything unclear before committing |

**Open questions**

- [ ] Confirm two-wheeler routing and toll info coverage for Malaysia in the Routes API, or fall back to car routes with motorway avoidance.
- [ ] Which source gives line-level disruption alerts for Rapid KL and KTM? (Live positions exist in data.gov.my GTFS-realtime; alerts may not.)
- [ ] Parking prices: no public API. Curate a small dataset for KLCC and Bangsar, or drop prices and show only locations?
- [ ] Keep Google Maps for display and accept no offline areas, or move to Mapbox or MapLibre?
- [ ] Is phone sign-in worth the SMS cost, or is Google and Apple sign-in enough?
- [ ] Which two Phase 6 features will you build?
- [ ] Play Store release, or APK plus web demo only?
