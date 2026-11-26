import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/features/search/domain/place_search_repository.dart';
import 'package:ctrlgo/features/search/domain/place_suggestion.dart';
import 'package:dio/dio.dart';

/// Places API (New) autocomplete:
/// https://developers.google.com/maps/documentation/places/web-service/place-autocomplete
class GooglePlacesRepository implements PlaceSearchRepository {
  /// `appHeaders` identify the app to a platform-restricted key
  /// (X-Android-Package and X-Android-Cert, or X-Ios-Bundle-Identifier).
  new(this._dio, {required this._apiKey, this._appHeaders = const {}});

  static const url = 'https://places.googleapis.com/v1/places:autocomplete';

  /// How far around the user to favour results.
  static const biasRadiusM = 20000.0;

  final Dio _dio;
  final String _apiKey;
  final Map<String, String> _appHeaders;

  @override
  Future<List<PlaceSuggestion>> autocomplete(
    String input, {
    required String sessionToken,
    GeoPosition? near,
  }) async {
    final latLng = switch (near) {
      final p? => {'latitude': p.lat, 'longitude': p.lng},
      null => null,
    };
    final response = await _dio.post<Map<String, dynamic>>(
      url,
      options: Options(headers: {'X-Goog-Api-Key': _apiKey, ..._appHeaders}),
      data: {
        'input': input,
        'sessionToken': sessionToken,
        'includedRegionCodes': ['my'],
        'languageCode': 'en',
        if (latLng != null) ...{
          'locationBias': {
            'circle': {'center': latLng, 'radius': biasRadiusM},
          },
          // Asks for distanceMeters in each prediction.
          'origin': latLng,
        },
      },
    );
    return parseAutocomplete(response.data ?? const {});
  }
}

/// Place predictions from an autocomplete response; query predictions
/// (search terms rather than places) are skipped.
List<PlaceSuggestion> parseAutocomplete(Map<String, dynamic> json) => [
  for (final s in [
    ...?json['suggestions'] as List?,
  ].cast<Map<String, dynamic>>())
    if (s['placePrediction'] case final Map<String, dynamic> p) _suggestion(p),
];

PlaceSuggestion _suggestion(Map<String, dynamic> p) {
  final format = p['structuredFormat'] as Map<String, dynamic>? ?? const {};
  final main =
      format['mainText'] as Map<String, dynamic>? ??
      p['text'] as Map<String, dynamic>? ??
      const {};
  final secondary = format['secondaryText'] as Map<String, dynamic>?;
  return PlaceSuggestion(
    placeId: p['placeId'] as String,
    mainText: main['text'] as String? ?? '',
    matches: [
      for (final m in (main['matches'] as List? ?? const []))
        (
          // The API omits startOffset when it is 0.
          start: (m as Map<String, dynamic>)['startOffset'] as int? ?? 0,
          end: m['endOffset'] as int,
        ),
    ],
    secondaryText: secondary?['text'] as String? ?? '',
    distanceM: p['distanceMeters'] as int?,
    types: [...?(p['types'] as List?)?.cast<String>()],
  );
}
