import 'dart:convert';
import 'dart:io';

import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/features/search/data/google_places_repository.dart';
import 'package:ctrlgo/features/search/domain/place_search_repository.dart';
import 'package:ctrlgo/features/search/domain/place_suggestion.dart';

/// A JSON file under `test_fixtures/`.
Map<String, dynamic> fixtureJson(String path) =>
    jsonDecode(File('test_fixtures/$path').readAsStringSync())
        as Map<String, dynamic>;

/// Answers every query with the recorded "klcc" response, parsed the way the
/// real repository parses it. Records each call.
class FixturePlaceSearchRepository implements PlaceSearchRepository {
  final List<({String input, String sessionToken})> calls = [];

  /// Set to make the next calls throw, as a dropped connection would.
  Exception? failWith;

  @override
  Future<List<PlaceSuggestion>> autocomplete(
    String input, {
    required String sessionToken,
    GeoPosition? near,
  }) async {
    calls.add((input: input, sessionToken: sessionToken));
    if (failWith case final e?) throw e;
    return parseAutocomplete(fixtureJson('places/autocomplete_klcc.json'));
  }
}
