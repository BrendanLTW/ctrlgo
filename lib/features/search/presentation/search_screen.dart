import 'package:ctrlgo/core/format/distance.dart';
import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_radius.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/ct_text.dart';
import 'package:ctrlgo/core/theme/ct_tones.dart';
import 'package:ctrlgo/core/theme/go_colors.dart';
import 'package:ctrlgo/core/widgets/ct_button.dart';
import 'package:ctrlgo/core/widgets/ct_icon.dart';
import 'package:ctrlgo/features/search/domain/autocomplete_search.dart';
import 'package:ctrlgo/features/search/domain/place_suggestion.dart';
import 'package:ctrlgo/features/search/presentation/place_search_controller.dart';
import 'package:ctrlgo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-screen route above the tabs, like the canvas (no nav bar).
const searchRoute = '/search';

/// `Search` artboard: type a place and pick from suggestions (US-1, FR-02).
/// Nearby, Saved and Recent sections arrive in 1.4, 1.5 and 4.7.
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
                AutocompleteIdle() => const SizedBox.shrink(),
                AutocompleteLoading(:final previous) => _Suggestions(previous),
                AutocompleteResults(:final suggestions)
                    when suggestions.isEmpty =>
                  _Message(l10n.noPlacesMatch),
                AutocompleteResults(:final suggestions) => _Suggestions(
                  suggestions,
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
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
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

class _Suggestions extends ConsumerWidget {
  const new(this.suggestions);

  final List<PlaceSuggestion> suggestions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (suggestions.isEmpty) return const SizedBox.shrink();
    final c = context.ctColors;
    return ListView(
      padding: const EdgeInsets.only(bottom: CtSpacing.sectionTop),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Text(
            context.l10n.suggestions.toUpperCase(),
            style: CtText.label.copyWith(color: c.muted),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: CtSpacing.screenX),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(CtRadius.r28),
            child: ColoredBox(
              color: c.surface,
              child: Column(
                children: [
                  for (final (i, s) in suggestions.indexed) ...[
                    if (i > 0) Divider(height: 1, color: c.fill),
                    _SuggestionRow(
                      s,
                      // shortcut: opens nothing until Routes (1.7); it ends
                      // the session as picking a place will.
                      onTap: ref
                          .read(placeSearchControllerProvider.notifier)
                          .endSession,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
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
