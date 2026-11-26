import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_suggestion.freezed.dart';

/// One autocomplete result (US-1).
@freezed
abstract class PlaceSuggestion with _$PlaceSuggestion {
  const factory({
    required String placeId,

    /// The place's name, e.g. "Suria KLCC".
    required String mainText,

    /// Where [mainText] matches what was typed, as [start, end) offsets.
    @Default([]) List<({int start, int end})> matches,

    /// Area or address, e.g. "Jalan Ampang, Kuala Lumpur".
    @Default('') String secondaryText,

    /// Straight-line distance from the user, when known.
    int? distanceM,

    /// Provider place types, most specific first.
    @Default([]) List<String> types,
  }) = _PlaceSuggestion;
}
