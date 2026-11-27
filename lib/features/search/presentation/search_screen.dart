import 'dart:async';

import 'package:ctrlgo/app/dependencies.dart';
import 'package:ctrlgo/core/format/distance.dart';
import 'package:ctrlgo/core/format/relative_day.dart';
import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_radius.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/ct_text.dart';
import 'package:ctrlgo/core/theme/ct_tones.dart';
import 'package:ctrlgo/core/theme/go_colors.dart';
import 'package:ctrlgo/core/widgets/ct_button.dart';
import 'package:ctrlgo/core/widgets/ct_chip.dart';
import 'package:ctrlgo/core/widgets/ct_icon.dart';
import 'package:ctrlgo/features/search/domain/autocomplete_search.dart';
import 'package:ctrlgo/features/search/domain/place_suggestion.dart';
import 'package:ctrlgo/features/search/domain/recent_search.dart';
import 'package:ctrlgo/features/search/domain/simpler_queries.dart';
import 'package:ctrlgo/features/search/presentation/place_search_controller.dart';
import 'package:ctrlgo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_screen.g.dart';

/// Full-screen route above the tabs, like the canvas (no nav bar).
const searchRoute = '/search';

@riverpod
Stream<List<RecentSearch>> recentSearches(Ref ref) =>
    ref.watch(recentSearchRepositoryProvider).watchRecent();

/// `Search` artboard: recents before typing, suggestions while typing, and
/// `SearchEmpty` when nothing matches (US-1, FR-02). Saved and Nearby
/// sections arrive in 1.5 and 4.7.
class SearchScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _query = TextEditingController();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  RecentSearchRepository get _recents =>
      ref.read(recentSearchRepositoryProvider);

  /// Puts [q] in the field and searches it (a recent phrase or a "Try").
  void _search(String q) {
    _query.value = TextEditingValue(
      text: q,
      selection: TextSelection.collapsed(offset: q.length),
    );
    ref.read(placeSearchControllerProvider.notifier).type(q);
  }

  void _pick(PlaceSuggestion s) {
    unawaited(
      _recents.add(
        RecentSearch.place(
          placeId: s.placeId,
          label: s.mainText,
          secondaryText: s.secondaryText,
        ),
      ),
    );
    // shortcut: opens nothing until Routes (1.7); it ends the session as
    // picking a place will.
    ref.read(placeSearchControllerProvider.notifier).endSession();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final c = context.ctColors;
    final state = ref.watch(placeSearchControllerProvider);
    final search = ref.read(placeSearchControllerProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(CtSpacing.screenX, 4, 8, 0),
              child: Row(
                spacing: 4,
                children: [
                  Expanded(
                    child: _SearchField(
                      controller: _query,
                      onChanged: search.type,
                      onSubmitted: (q) {
                        if (q.trim().isNotEmpty) {
                          unawaited(_recents.add(RecentSearch.query(query: q)));
                        }
                      },
                      onClear: () {
                        _query.clear();
                        search.type('');
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: c.ink,
                      textStyle: CtText.body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      minimumSize: const Size(0, CtSize.target),
                    ),
                    child: Text(l10n.cancel),
                  ),
                ],
              ),
            ),
            // DESIGN §5: a thin go bar while loading, results stay put.
            SizedBox(
              height: 4,
              child: state is AutocompleteLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: CtSpacing.screenX * 2,
                      ),
                      child: LinearProgressIndicator(
                        color: context.goColors.go,
                        backgroundColor: Colors.transparent,
                        semanticsLabel: l10n.loadingSuggestions,
                      ),
                    )
                  : null,
            ),
            Expanded(
              child: switch (state) {
                AutocompleteIdle() => _Recents(onSearch: _search),
                AutocompleteLoading(:final previous) => _Suggestions(
                  previous,
                  onPick: _pick,
                ),
                AutocompleteResults(:final query, :final suggestions)
                    when suggestions.isEmpty =>
                  _SearchEmpty(query, onTry: _search),
                AutocompleteResults(:final suggestions) => _Suggestions(
                  suggestions,
                  onPick: _pick,
                ),
                AutocompleteFailed() => _Message(
                  l10n.suggestionsFailed,
                  action: CtTextButton(
                    label: l10n.tryAgain,
                    onPressed: search.retry,
                  ),
                ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Canvas `.search`: 52 px pill with icon, input and clear button.
class _SearchField extends StatelessWidget {
  const new({
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    final l10n = context.l10n;
    return Container(
      height: CtSize.searchField,
      padding: const EdgeInsets.only(left: 18, right: 6),
      decoration: ShapeDecoration(
        color: c.surface,
        shape: const StadiumBorder(),
      ),
      child: Row(
        spacing: CtSpacing.cardGap,
        children: [
          CtIconView(CtIcon.search, size: CtSize.icon, color: c.muted),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              autofocus: true,
              textInputAction: TextInputAction.search,
              style: CtText.body.copyWith(
                color: c.ink,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: c.ink,
              decoration: InputDecoration(
                hintText: l10n.searchHint,
                hintStyle: CtText.body.copyWith(
                  color: c.muted,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
          ListenableBuilder(
            listenable: controller,
            builder: (context, _) => controller.text.isEmpty
                ? const SizedBox.shrink()
                : Semantics(
                    button: true,
                    label: l10n.clearSearch,
                    excludeSemantics: true,
                    child: Material(
                      color: c.fill,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: onClear,
                        child: SizedBox.square(
                          dimension: CtSize.tileMd,
                          child: CtIconView(
                            CtIcon.close,
                            size: CtSize.chipIcon,
                            color: c.ink,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _Suggestions extends StatelessWidget {
  const new(this.suggestions, {required this.onPick});

  final List<PlaceSuggestion> suggestions;
  final ValueChanged<PlaceSuggestion> onPick;

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) return const SizedBox.shrink();
    return ListView(
      padding: const EdgeInsets.only(bottom: CtSpacing.sectionTop),
      children: [
        _SectionLabel(context.l10n.suggestions),
        _Group([
          for (final s in suggestions)
            _SuggestionRow(s, onTap: () => onPick(s)),
        ]),
      ],
    );
  }
}

/// Recent places and phrases, newest first, with Clear.
class _Recents extends ConsumerWidget {
  const new({required this.onSearch});

  final ValueChanged<String> onSearch;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recents = ref.watch(recentSearchesProvider).value ?? const [];
    if (recents.isEmpty) return const SizedBox.shrink();
    final l10n = context.l10n;
    final c = context.ctColors;
    final now = ref.watch(clockProvider).now();
    return ListView(
      padding: const EdgeInsets.only(bottom: CtSpacing.sectionTop),
      children: [
        _SectionLabel(
          l10n.recent,
          action: TextButton(
            onPressed: () =>
                unawaited(ref.read(recentSearchRepositoryProvider).clear()),
            style: TextButton.styleFrom(
              foregroundColor: c.muted,
              textStyle: CtText.chip,
              minimumSize: const Size(CtSize.target, 32),
            ),
            child: Semantics(
              label: l10n.clearRecents,
              excludeSemantics: true,
              child: Text(l10n.clear),
            ),
          ),
        ),
        _Group([
          for (final r in recents)
            _RecentRow(
              r,
              when: switch (r.searchedAt) {
                final at? => relativeDay(at, now, l10n),
                null => null,
              },
              onTap: switch (r) {
                RecentQuery(:final query) => () => onSearch(query),
                // shortcut: a recent place opens Routes once 1.7 exists.
                RecentPlace() => () {},
              },
            ),
        ]),
      ],
    );
  }
}

/// Canvas Recent row: small grey clock tile, name, area · when.
class _RecentRow extends StatelessWidget {
  const new(this.recent, {required this.when, required this.onTap});

  final RecentSearch recent;
  final String? when;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    final tone = context.tones.grey;
    final (title, area) = switch (recent) {
      RecentPlace(:final label, :final secondaryText) => (label, secondaryText),
      RecentQuery(:final query) => (query, ''),
    };
    final sub = [if (area.isNotEmpty) area, ?when].join(' · ');
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: CtSize.rowRecent),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Row(
            spacing: 14,
            children: [
              Container(
                width: CtSize.tileSm,
                height: CtSize.tileSm,
                decoration: BoxDecoration(
                  color: tone.tile,
                  borderRadius: BorderRadius.circular(CtRadius.r9),
                ),
                child: CtIconView(
                  recent is RecentQuery ? CtIcon.search : CtIcon.clock,
                  size: 15,
                  color: tone.fg,
                  stroke: CtIconStroke.tile,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: CtText.rowTitle.copyWith(
                        fontSize: 15,
                        color: c.ink,
                      ),
                    ),
                    if (sub.isNotEmpty)
                      Text(
                        sub,
                        style: CtText.meta.copyWith(color: c.muted),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// `SearchEmpty` artboard: what went wrong, shorter searches to try, and
/// dropping a pin instead.
class _SearchEmpty extends StatelessWidget {
  const new(this.query, {required this.onTry});

  final String query;
  final ValueChanged<String> onTry;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    final l10n = context.l10n;
    final tries = simplerQueries(query);
    return ListView(
      padding: const EdgeInsets.only(top: 64, bottom: CtSpacing.sectionTop),
      children: [
        Center(
          child: Container(
            width: CtSize.stateIcon,
            height: CtSize.stateIcon,
            decoration: BoxDecoration(color: c.fill, shape: BoxShape.circle),
            child: CtIconView(
              CtIcon.searchOff,
              size: CtSize.stateGlyph,
              color: c.ink,
              stroke: CtIconStroke.state,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 22, 32, 0),
          child: Column(
            spacing: 8,
            children: [
              Text(
                l10n.noPlacesMatch,
                textAlign: TextAlign.center,
                style: CtText.heroValue.copyWith(letterSpacing: 0),
              ),
              Text(
                l10n.searchEmptyBody,
                textAlign: TextAlign.center,
                style: CtText.body.copyWith(color: c.muted, height: 1.5),
              ),
            ],
          ),
        ),
        if (tries.isNotEmpty) ...[
          _SectionLabel(l10n.tryLabel, top: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: CtSpacing.screenX),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final t in tries)
                  CtChip(label: t, onPressed: () => onTry(t)),
              ],
            ),
          ),
        ],
        const SizedBox(height: 20),
        _Group([
          InkWell(
            // shortcut: PlaceEdit with a map pin arrives in 1.5.
            onTap: () {},
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: CtSize.row),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                child: Row(
                  spacing: 14,
                  children: [
                    Container(
                      width: CtSize.tileMd,
                      height: CtSize.tileMd,
                      decoration: BoxDecoration(
                        color: context.tones.grey.tile,
                        borderRadius: BorderRadius.circular(CtRadius.r13),
                      ),
                      child: CtIconView(
                        CtIcon.pinAdd,
                        size: 19,
                        color: context.tones.grey.fg,
                        stroke: CtIconStroke.tile,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.dropPin,
                            style: CtText.rowTitle.copyWith(color: c.ink),
                          ),
                          Text(
                            l10n.dropPinSub,
                            style: CtText.meta.copyWith(color: c.muted),
                          ),
                        ],
                      ),
                    ),
                    CtIconView(
                      CtIcon.chevronRight,
                      size: 20,
                      color: c.ink,
                      stroke: CtIconStroke.chevron,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}

/// Uppercase section label (canvas `.sec .lbl`), with an optional action.
class _SectionLabel extends StatelessWidget {
  const new(this.text, {this.action, this.top = 16});

  final String text;
  final Widget? action;
  final double top;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(24, top, action == null ? 24 : 12, 8),
    child: Row(
      children: [
        Expanded(
          child: Text(
            text.toUpperCase(),
            style: CtText.label.copyWith(color: context.ctColors.muted),
          ),
        ),
        ?action,
      ],
    ),
  );
}

/// White rounded list with hairlines between rows (canvas `.group`).
class _Group extends StatelessWidget {
  const new(this.children);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: CtSpacing.screenX),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(CtRadius.r28),
        child: Material(
          color: c.surface,
          child: Column(
            children: [
              for (final (i, child) in children.indexed) ...[
                if (i > 0) Divider(height: 1, color: c.fill),
                child,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Canvas `.gi`: type tile, name with matches highlighted, area, distance.
class _SuggestionRow extends StatelessWidget {
  const new(this.suggestion, {required this.onTap});

  final PlaceSuggestion suggestion;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    final l10n = context.l10n;
    final kind = _PlaceKind.of(suggestion.types);
    final tone = kind.tone(context.tones);
    final typeLabel = kind.label(l10n);
    final sub = [
      ?typeLabel,
      if (suggestion.secondaryText.isNotEmpty) suggestion.secondaryText,
    ].join(' · ');

    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: CtSize.row),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            spacing: 14,
            children: [
              Container(
                width: CtSize.tileMd,
                height: CtSize.tileMd,
                decoration: BoxDecoration(
                  color: tone.tile,
                  borderRadius: BorderRadius.circular(CtRadius.r13),
                ),
                child: CtIconView(
                  kind.icon,
                  size: 19,
                  color: tone.fg,
                  stroke: CtIconStroke.tile,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: highlightSpans(
                          suggestion.mainText,
                          suggestion.matches,
                          TextStyle(backgroundColor: context.tones.yellow.tile),
                        ),
                      ),
                      style: CtText.rowTitle.copyWith(color: c.ink),
                    ),
                    if (sub.isNotEmpty)
                      Text(
                        sub,
                        style: CtText.meta.copyWith(color: c.muted),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              if (suggestion.distanceM case final m?)
                Text(
                  formatDistance(m),
                  style: CtText.chip.copyWith(color: c.muted),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// [text] split into plain and highlighted runs at [matches]. Overlapping
/// or out-of-range matches are clamped rather than trusted.
List<TextSpan> highlightSpans(
  String text,
  List<({int start, int end})> matches,
  TextStyle highlight,
) {
  final spans = <TextSpan>[];
  var at = 0;
  for (final m in [...matches]..sort((a, b) => a.start - b.start)) {
    final start = m.start.clamp(at, text.length);
    final end = m.end.clamp(start, text.length);
    if (start > at) spans.add(TextSpan(text: text.substring(at, start)));
    if (end > start) {
      spans.add(TextSpan(text: text.substring(start, end), style: highlight));
    }
    at = end;
  }
  if (at < text.length) spans.add(TextSpan(text: text.substring(at)));
  return spans;
}

class _Message extends StatelessWidget {
  const new(this.text, {this.action});

  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      children: [
        Text(
          text,
          textAlign: TextAlign.center,
          style: CtText.body.copyWith(color: context.ctColors.muted),
        ),
        ?action,
      ],
    ),
  );
}

/// How a result looks, from its most telling place type.
enum _PlaceKind {
  mall(CtIcon.bag),
  park(CtIcon.tree),
  station(CtIcon.train),
  food(CtIcon.food),
  cafe(CtIcon.coffee),
  other(CtIcon.location);

  new(this.icon);

  final CtIcon icon;

  static _PlaceKind of(List<String> types) {
    for (final t in types) {
      switch (t) {
        case 'shopping_mall':
          return mall;
        case 'park':
          return park;
        case 'train_station' ||
            'subway_station' ||
            'light_rail_station' ||
            'transit_station':
          return station;
        case 'restaurant' || 'food':
          return food;
        case 'cafe' || 'coffee_shop':
          return cafe;
      }
    }
    return other;
  }

  ToneSet tone(CtTones t) => switch (this) {
    mall => t.pink,
    park => t.green,
    station => t.red,
    food => t.orange,
    cafe => t.yellow,
    other => t.grey,
  };

  String? label(AppLocalizations l10n) => switch (this) {
    mall => l10n.placeTypeMall,
    park => l10n.placeTypePark,
    station => l10n.placeTypeStation,
    food => l10n.placeTypeRestaurant,
    cafe => l10n.placeTypeCafe,
    other => null,
  };
}
