import 'dart:convert';
import 'dart:typed_data';

import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/features/search/data/google_places_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fixtures.dart';

/// Answers every request with [body] and keeps the request for inspection.
class _FixtureAdapter implements HttpClientAdapter {
  new(this.body);

  final Map<String, dynamic> body;
  RequestOptions? last;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    last = options;
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late _FixtureAdapter adapter;
  late GooglePlacesRepository repo;

  setUp(() {
    adapter = _FixtureAdapter(fixtureJson('places/autocomplete_klcc.json'));
    repo = GooglePlacesRepository(
      Dio()..httpClientAdapter = adapter,
      apiKey: 'test-key',
      appHeaders: const {'X-Android-Package': 'app.ctrlgo'},
    );
  });

  test('parses place predictions from the fixture', () async {
    final results = await repo.autocomplete('klcc', sessionToken: 't');

    expect(results.map((s) => s.mainText), [
      'Suria KLCC',
      'KLCC Park',
      'KLCC LRT Station',
    ], reason: 'the query prediction is skipped');
    final suria = results.first;
    expect(suria.placeId, 'fixture-suria-klcc');
    expect(suria.matches, [(start: 6, end: 10)]);
    expect(suria.secondaryText, startsWith('Jalan Ampang'));
    expect(suria.distanceM, 6812);
    expect(suria.types.first, 'shopping_mall');
    expect(results[1].matches, [
      (start: 0, end: 4),
    ], reason: 'a missing startOffset means 0');
  });

  test('sends the session token, region and location bias', () async {
    await repo.autocomplete(
      'klcc',
      sessionToken: 'session-1',
      near: GeoPosition(
        lat: 3.111,
        lng: 101.666,
        timestamp: DateTime.utc(2026),
      ),
    );

    final o = adapter.last!;
    expect(o.method, 'POST');
    expect(o.uri.toString(), GooglePlacesRepository.url);
    expect(o.headers['X-Goog-Api-Key'], 'test-key');
    expect(o.headers['X-Android-Package'], 'app.ctrlgo');
    final body = o.data as Map<String, dynamic>;
    expect(body['input'], 'klcc');
    expect(body['sessionToken'], 'session-1');
    expect(body['includedRegionCodes'], ['my']);
    expect(body['locationBias'], {
      'circle': {
        'center': {'latitude': 3.111, 'longitude': 101.666},
        'radius': GooglePlacesRepository.biasRadiusM,
      },
    });
    expect(body['origin'], {'latitude': 3.111, 'longitude': 101.666});
  });

  test('without a position there is no bias or origin', () async {
    await repo.autocomplete('klcc', sessionToken: 's');

    final body = adapter.last!.data as Map<String, dynamic>;
    expect(body.containsKey('locationBias'), isFalse);
    expect(body.containsKey('origin'), isFalse);
  });

  test('an empty response is no suggestions', () {
    expect(parseAutocomplete(const {}), isEmpty);
  });
}
