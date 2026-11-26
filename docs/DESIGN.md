# ctrlGo — Design Specification

Companion to [`docs/PRD.md`](PRD.md) and [`docs/PLAN.md`](PLAN.md). Source of truth for visuals: the [ctrlGo design canvas](https://claude.ai/artifact/RE5X66qRKwFtDys5JetR2q) (every screen in light and dark, plus the design system board).

## 1. Principles

1. **Map first.** On Explore the map fills the screen; everything else is a floating card or a bottom sheet.
2. **One family.** ctrlGo uses the ctrlWorks system shared with ctrlSpend and ctrlTask: Poppins, a cool off-white ground, white cards with large radii, near-black ink as the action colour, pastel tiles.
3. **Blue means you.** Go blue is reserved for your position, your route and your sharing state. Buttons, selections and the nav stay ink.
4. **Thumb zone.** Primary actions (Start, End, Share, Report, mode) sit in the bottom 40%. Only search and back live at the top.
5. **Sharing is always visible and always ends.** A green pulse banner whenever you share; every share shows its end time.
6. **No typing while driving.** One-tap tiles, voice, and targets of 56 px or more during navigation.
7. **Honest data.** Anything that isn't live says how old it is.

## 2. Tokens

### 2.1 Family core (shared with ctrlSpend and ctrlTask)

| Token | Light | Dark | Use |
|---|---|---|---|
| `ground` | `#F7F8FA` | `#0B1018` | Scaffold background |
| `surface` | `#FFFFFF` | `#161D29` | Cards, sheets, nav |
| `ink` | `#101828` | `#F2F4F7` | Text, primary buttons, selected states |
| `onInk` | `#FFFFFF` | `#0B1018` | Text on ink |
| `ink2` | `#344054` | `#D0D5DD` | Secondary text on tinted fills |
| `muted` | `#5B6B86` | `#98A2B3` | Meta text, inactive icons |
| `fill` | `#EEF1F6` | `#232C3A` | Chips, soft buttons, dividers |
| `fill2` | `#F2F4F7` | `#232C3A` | Inset areas inside sheets |
| `border` | `#D0D5DD` | `#475467` | Toggles off, radio rings |
| `hero` | `#101828` | `#1C2536` | Dark hero cards, turn banner |
| `positive` | `#067647` | `#47CD89` | Arrived, open now, on time |
| `negative` | `#D92D20` | `#F97066` | Destructive, closed, speeding |
| `warning` | `#B54708` | `#FDB022` | Delays, closing soon, estimates |
| `scrim` | navy 42% | black 60% | Behind modal sheets and dialogs |

**Tones** (tile background · foreground · chart/marker), used for icon tiles, friend avatars, transit lines and traffic:

| Tone | Light | Dark |
|---|---|---|
| orange `or` | `#FFE2B8` · `#C25E00` · `#FB8C00` | 20% · `#FFB547` · `#FFB547` |
| yellow `ye` | `#FFF0B8` · `#8A6100` · `#F5B800` | 20% · `#FFD34D` · `#FFD34D` |
| green `gr` | `#C9F3D5` · `#1E8A43` · `#17B26A` | 22% · `#5BD996` · `#47CD89` |
| blue `bl` | `#CDE6FB` · `#1769C2` · `#2196F3` | 22% · `#6CB8FF` · `#6CB8FF` |
| purple `pu` | `#E4DBF7` · `#6D3FD1` · `#7C4DDB` | 26% · `#B69BFF` · `#B69BFF` |
| pink `pk` | `#FBD3E1` · `#C8174F` · `#F0457A` | 22% · `#FF7AA2` · `#FF7AA2` |
| red `rd` | `#FEE4E2` · `#D92D20` · `#F04438` | 22% · `#FF8A80` · `#F97066` |
| grey `gy` | `#EEF1F6` · `#5B6B86` · `#98A2B3` | `#232C3A` · `#98A2B3` · `#475467` |

### 2.2 ctrlGo additions

| Token | Light | Dark | Use |
|---|---|---|---|
| `go` | `#3A6BF0` | `#6C95FF` | Your puck, your route, selected ETA bubble, sharing icon |
| `goSoft` | `#DCE6FF` | go at 22% | Sharing banner, location-off tile |
| `goHalo` | go at 16% | go at 22% | Puck accuracy halo and heading cone |
| `altRoute` | `#A3ADBF` | `#4A566B` | Unselected routes, travelled route, estimated position |
| `routeCasing` | `#FFFFFF` | `#0B1018` | Outline under route lines |

The logo arrow is `#4C7DFF`. The UI uses the deeper `#3A6BF0` so white text on it reaches 4.6:1. In dark mode, text on `go` is `#0B1018`.

### 2.3 Map style

| Feature | Light | Dark |
|---|---|---|
| Land | `#EEF1F5` | `#0F1623` |
| Blocks | `#E6EAF0` | `#131B29` |
| Minor road | `#FFFFFF`, 4 px | `#1B2433` |
| Major road | `#FFFFFF`, 9 px, casing `#DDE2EA` | `#263142`, casing `#0B1018` |
| Highway | `#FFF4DA`, casing `#F2DDA8` | `#3A3424`, casing `#0B1018` |
| Water | `#C7E0F7` | `#0E2236` |
| Park | `#D3EED9` | `#10261B` |
| Rail | `#B7BFCC` dashed | `#2E3848` dashed |
| District labels | `#7D879A`, 9.5 / 600, caps, +1.4 tracking | `#6B778C` |

Hide POI icons and business labels by default; ctrlGo draws its own markers.

### 2.4 Meaning colours

| Meaning | Tone | Shown as |
|---|---|---|
| Traffic clear | green | Plain go route; green dot in the route card |
| Traffic moderate | orange | Orange segment on route and dot |
| Traffic heavy | red | Red segment, dot, "+n min" tag |
| Incident marker | orange or the report type's tone | 34–36 px circle with a white glyph and surface ring |
| LRT Kelana Jaya | red | Leg chip and line on map |
| MRT Kajang | green | Leg chip |
| KTM Komuter | blue | Leg chip |
| RapidKL bus | yellow | Leg chip |
| Friend | one tone per friend | Avatar tile, map pin ring |
| Stale friend | grey | Faded avatar, grey ring, age label |

### 2.5 Typography (Poppins, tabular figures)

| Style | Size / weight | Tracking | Use |
|---|---|---|---|
| `turnDistance` | 30 / 700 | −0.8 | "450 m" in the turn banner |
| `eta` | 28 / 700 | −0.6 | Arrival time in the nav panel |
| `pageTitle` | 26 / 700 | −0.3 | Tab titles |
| `heroValue` | 22 / 700 | −0.4 | Route time, group name |
| `header` | 20 / 700 | 0 | Sheet and app-bar titles |
| `rowTitle` | 16 / 600 | 0 | List rows, turn instruction |
| `body` | 15 / 400–500 | 0 | Body and field text |
| `meta` | 13 / 400 | 0 | Secondary lines |
| `label` | 13 / 600 caps | +0.7 | Section labels |
| `chip` | 14 / 600 | 0 | Chips, pills |
| `small` | 11–12 / 600 | 0 | Mode labels, leg chips, ETA bubbles |

### 2.6 Spacing, radius, elevation

- **Spacing:** 16 px screen margin; 10–12 px between cards; 14–20 px inside cards; 20–24 px before section labels.
- **Radius:** 9 · 13 · 16 · 18 · 22 · 24 · 28 · 32 · pill (999). Cards 24–28, sheets 32 (top corners), buttons 22, inputs 18, icon tiles 13–16.
- **Elevation:** shadows only on floating things: nav, FAB, map buttons, floating search, sheets, toasts, dialogs. Light `0 8 28 rgba(16,24,40,.08)`; dark `0 8 28 rgba(0,0,0,.5)`.
- **Touch targets:** 44 px minimum; 48 px for map buttons; 56 px or more for anything used while driving.

### 2.7 Iconography

24 px grid, 1.8 px stroke, round caps and joins, no fill except the Go arrow and location glyphs. Icon tiles: 48 / 40 / 28 px with tone background. Never use emoji.

## 3. Components

Each maps to a Flutter widget that reads only from the theme (no hard-coded colours).

| Component | Widget | Variants and states | Notes |
|---|---|---|---|
| Floating search | `FloatingSearch` | idle, with voice button, location off | 56 px pill, shadow, opens Search |
| Quick destination chip | `CtChip` | default, selected, small | Home, Work, saved |
| Mode selector | `ModeSelector` | on-map (surface + shadow), in-sheet (fill2); car, motorcycle, walk, transit | Radio group semantics |
| Location puck | `LocationPuck` | live (go + halo + cone), navigating (white disc + go arrow), estimated (altRoute, dashed ring) | Halo breathes every 2 s when live |
| Destination pin | `DestinationPin` | default | Ink teardrop with onInk dot |
| Friend pin | `FriendPin` | live, selected (shows first name), stale (faded, grey ring) | Tip anchored at position |
| ETA bubble | `EtaBubble` | default, selected (go fill) | Tappable; selects the route |
| Report marker | `ReportMarker` | per report type | 36 px, surface ring |
| Route line | `RouteLayer` | selected (go + casing), alternative (altRoute), travelled (altRoute 80%), traffic overlay | Selected always drawn last |
| Route option card | `RouteOptionCard` | selected (ink 2 px inset ring), alternative | Time, distance, tag, traffic dot + via |
| Transit legs | `TransitLegs` | walk, LRT, MRT, KTM, bus | Chevron separators |
| Transit timeline | `TransitTimeline` | walk (dotted), ride (line tone), interchange, arrive | Live departure row with dot |
| Turn banner | `TurnBanner` | normal, rerouting (spinner), GPS lost (`#344054` background) | Lanes row; live region |
| Then strip | `ThenStrip` | — | Tucked under the banner |
| Speed | `SpeedBadge`, `LimitSign` | normal, speeding (negative fill) | Hysteresis 3 s |
| Nav panel | `NavPanel` | normal, estimated ETA, with share row | End button in negative |
| Bottom sheet | `CtSheet` | non-modal over map, modal with scrim | Handle, 32 px top radius |
| Sharing banner | `ShareBanner` | sharing (goSoft + pulse), not sharing (fill) | Stop / Share action |
| Duration picker | `DurationPicker` | 15 min, 1 hour, Today, Always | Sub-label shows the end time |
| Friend row | `FriendTile` | live, stale, not sharing (Ask) | Distance and ETA on the right |
| Group hero | `GroupHeroCard` | live | Avatar stack, pulse |
| Report tile | `ReportTypeTile` | 8 types | 96 px tall, 2-column grid |
| Hazard sheet | `HazardSheet` | ask, thanked | Expiry bar, two 58 px buttons |
| Place card | `PlaceCard` | open, closing soon, closed | Photo, rating, distance |
| SOS button | `SosButton` | idle, counting | 150 px, pulse ring |
| Toast | `CtToast` | success with Undo | 3.5 s, above the nav |
| Dialog | `ConfirmDialog` | destructive | Remove friend, block, delete |
| Nav bar + FAB | `CtNavBar`, `CtFab` | Explore, Friends, Saved, Profile | Pill nav 278 px; FAB action per tab |
| Empty state | `EmptyState` | icon circle, title, body, actions | — |
| Skeleton | `Skeleton` | line, block | Shimmer 1.3 s |

**FAB per tab:** Explore → Get directions (Go arrow) · Friends → Share my location · Saved → Add place · Profile → Get directions.

## 4. Screens

Names match the artboards on the canvas; each has a `…Dark` twin.

### Explore

| Artboard | Purpose | Key states |
|---|---|---|
| `Main` | Map home, search, quick chips, commute card, mode selector | Mode switch updates the commute card |
| `Search` | Autocomplete, nearby categories, saved, recents | Typing, cleared |
| `SearchEmpty` | No results | Suggestions, drop a pin |
| `Routes` | Up to 3 car routes with traffic | Route selected via card or bubble |
| `RoutesLoading` | Skeleton while fetching | Progress bar |
| `NoRoute` | Offline error | Retry, saved timetable |
| `RoutesTransit` | Transit options | Option selected; Steps |
| `TransitDetail` | Step timeline, interchange, disruption | Live and delayed lines |
| `RoutePrefs` | Car or motorcycle, avoid, tolls | Toll total updates |
| `Navigate` | Turn-by-turn | Mute, along route, report, add stop |
| `NavReroute` | Missed turn | Rerouting → new route card |
| `GpsLost` | Lost signal | Estimated → recovered |
| `AlongRoute` | Detour search | Petrol, food, parking, coffee |
| `MultiStop` | Stops timeline | Remove stop updates totals |
| `ReportSheet` | Report type grid | Picked → thanks with Undo |
| `HazardAlert` | Report ahead | Still there / Not there |
| `DriveLock` | Typing paused | Passenger unlock |
| `Arrived` | Trip summary | Sharing ended note |
| `Nearby`, `Place` | Discovery and detail | Category switch, hours expanded, saved to collection |
| `LocDenied` | Location off | Open Settings |

### Friends

| Artboard | Purpose | Key states |
|---|---|---|
| `Friends` | People list, request, sharing banner | Stop sharing → toast with Undo |
| `FriendsEmpty` | No friends | Add, invite |
| `LiveMap` | Friends on map | Pin selection, Notify me |
| `ShareSheet` | Duration, mode, people | Shared → success sheet |
| `AddFriend` | Search, QR, contacts | Requested, invited |
| `FriendManage` | Sharing both ways, emergency, remove, block | Confirm dialogs |
| `Groups`, `GroupCreate`, `GroupMap` | Go Together | Members, menu (leave, end) |

### Saved and Profile

| Artboard | Purpose | Key states |
|---|---|---|
| `Saved` | Home, Work, favourites, recent | Edit mode, delete with Undo |
| `PlaceEdit` | Name, kind, colour, alerts | Switches |
| `Profile` | Account, stats, settings | — |
| `Privacy` | Who can see you, permission, data | Stop all |
| `OfflineMaps` | Areas, storage, battery mode | Cancel download |
| `Emergency` | SOS, contacts | Countdown, sharing |

## 5. Patterns

- **Sheets over the map:** route options, along-route, live map and arrival are non-modal; the map stays interactive above them. Share, report and confirmations are modal with a scrim.
- **Undo over confirm:** reversible actions (delete place, stop sharing, report) act at once with a 3.5–5 s Undo toast. Irreversible or social actions (remove, block, end group for all) use a dialog.
- **Stale data:** anything older than its refresh interval shows its age ("12 min ago", "updated 9:30"). Estimates use a tilde ("~10:00") and the warning colour.
- **Loading:** skeletons in place of content plus a 4 px go progress bar on sheets. Never a full-screen spinner.
- **Errors:** say what happened, what still works, and one action ("Try again").
- **Permissions:** explain before asking; each denied state says what still works.

## 6. Motion

| Interaction | Spec |
|---|---|
| Route select | Selected line redraws on top in 200 ms; others fade to altRoute |
| Sheets | Slide up 280 ms ease-out over a 42% scrim |
| Puck | Halo breathes every 2 s while GPS is live; turns grey when lost |
| Turn banner | Crossfade 180 ms at each manoeuvre |
| Reroute | Spinner in banner, then the "New route" card slides down 220 ms |
| Toasts | Slide up 300 ms; auto-dismiss 3.5 s |
| Check / success | Scale 0.7 → 1.18 → 1 over 350 ms |
| SOS | Pulse ring 1 s loop while counting |
| Loading | Progress sweep 1.2 s; skeleton shimmer 1.3 s |

Respect the system "reduce motion" setting: replace slides and pulses with fades.

## 7. Accessibility

- WCAG AA contrast in both themes, including 11–13 px labels and text on go.
- Semantic labels on every icon-only button and map marker ("Aisyah, sharing live, Mid Valley, 2.1 km").
- The turn banner is a polite live region; hazard and speeding alerts are assertive.
- Never colour alone: traffic shows a tag ("+4 min") as well as colour; stale friends show an age as well as fading.
- Layouts hold at 200% text scale; the turn banner truncates street names before distance.
- Radio, switch and checkbox semantics on mode selectors, toggles and people pickers.

## 8. Content and voice

- Plain, short and calm: "Turn right onto Jalan Sultan Ismail", "Sharing stops by itself at 6:00 PM."
- Malaysian context: RM, km, 12-hour times (9:41 AM), local place names (Jalan, not Street).
- Times are absolute ("until 6:00 PM") rather than relative where it matters for privacy.
- Voice prompts: "In 300 metres, turn left onto Jalan Travers." No street-name abbreviations.

## 9. Flutter mapping

| Design | Flutter |
|---|---|
| Family core colours | `ColorScheme` (surface = ground, surfaceContainerLowest = surface, primary = ink, onPrimary = onInk, onSurfaceVariant = muted, surfaceContainerHigh = fill, outlineVariant = fill) |
| Tones | `ThemeExtension<CtTones>` with `ToneSet(tile, fg, chart)` |
| ctrlGo colours | `ThemeExtension<GoColors>` (go, goSoft, goHalo, altRoute, routeCasing) |
| Map style | `assets/map/light.json`, `dark.json` applied with the theme |
| Radius, spacing | `CtRadius.xs … xxl, pill`; `CtSpacing` constants |
| Type | `GoogleFonts.poppinsTextTheme()` + `FontFeature.tabularFigures()`; named styles on a `CtText` extension |

## 10. Known issues to fix on the canvas

- **Fuel prices per station.** `AlongRoute` shows different RON97 prices per station. Malaysian pump prices are set nationally each week, so show one weekly price in the header and sort stations by detour only.
- **Parking prices** are sample values with no data source yet (see PRD open questions).
- **Place photos** are labelled placeholders, and the phone number is a placeholder.
- **Map** is an illustration; the real app uses the map style in §2.3.
