import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/features/search/domain/place_suggestion.dart';

abstract interface class PlaceSearchRepository {
  /// Suggestions for [input], biased towards [near]. Every call in one
  /// search shares [sessionToken], so the provider bills the keystrokes and
  /// the final pick as one session.
  Future<List<PlaceSuggestion>> autocomplete(
    String input, {
    required String sessionToken,
    GeoPosition? near,
  });
}
