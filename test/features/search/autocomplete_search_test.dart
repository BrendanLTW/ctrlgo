import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/features/search/domain/autocomplete_search.dart';
import 'package:ctrlgo/features/search/domain/place_search_repository.dart';
import 'package:ctrlgo/features/search/domain/place_suggestion.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

/// Answers after [delay], echoing the input as a single suggestion.
class _Repo implements PlaceSearchRepository {
  final calls = <({String input, String token})>[];
  Duration delay = Duration.zero;
  bool fail = false;

  @override
  Future<List<PlaceSuggestion>> autocomplete(
    String input, {
    required String sessionToken,
    GeoPosition? near,
  }) async {
    calls.add((input: input, token: sessionToken));
    await Future<void>.delayed(delay);
    if (fail) throw StateError('offline');
    return [PlaceSuggestion(placeId: input, mainText: input)];
  }
}

const _ms = Duration(milliseconds: 1);

void main() {
  late _Repo repo;
  late AutocompleteSearch search;
  late int tokens;

  void setUpSearch() {
    repo = _Repo();
    tokens = 0;
    search = AutocompleteSearch(
      repo,
      newSessionToken: () => 'token-${++tokens}',
    );
  }

  List<String> results() => switch (search.state) {
    AutocompleteResults(:final suggestions) => [
      for (final s in suggestions) s.mainText,
    ],
    _ => const [],
  };

  group('debounce', () {
    test('fast typing sends one request, 250 ms after the last key', () {
      fakeAsync((async) {
        setUpSearch();
        for (final q in ['k', 'kl', 'klc', 'klcc']) {
          search.type(q);
          async.elapse(const Duration(milliseconds: 100));
        }
        expect(repo.calls, isEmpty, reason: '100 ms after "klcc"');

        async.elapse(const Duration(milliseconds: 149));
        expect(repo.calls, isEmpty, reason: '249 ms after "klcc"');

        async.elapse(_ms);
        expect(repo.calls.map((c) => c.input), ['klcc']);
        async.flushMicrotasks();
        expect(results(), ['klcc']);
      });
    });

    test('a pause between words sends both', () {
      fakeAsync((async) {
        setUpSearch();
        search.type('suria');
        async.elapse(const Duration(milliseconds: 300));
        search.type('suria klcc');
        async.elapse(const Duration(milliseconds: 300));

        expect(repo.calls.map((c) => c.input), ['suria', 'suria klcc']);
      });
    });

    test('clearing the field goes idle without a request', () {
      fakeAsync((async) {
        setUpSearch();
        search
          ..type('kl')
          ..type('  ');
        async.elapse(const Duration(seconds: 1));

        expect(repo.calls, isEmpty);
        expect(search.state, isA<AutocompleteIdle>());
      });
    });

    test('keeps the last results on screen while the next query loads', () {
      fakeAsync((async) {
        setUpSearch();
        search.type('kl');
        async.elapse(const Duration(milliseconds: 250));
        search.type('klcc');

        final state = search.state as AutocompleteLoading;
        expect(state.previous.map((s) => s.mainText), ['kl']);
      });
    });
  });

  group('session token', () {
    test('every request in one search reuses the same token', () {
      fakeAsync((async) {
        setUpSearch();
        for (final q in ['su', 'suria', 'suria k']) {
          search.type(q);
          async.elapse(const Duration(milliseconds: 300));
        }

        expect(repo.calls.map((c) => c.token).toSet(), {'token-1'});
        expect(tokens, 1);
      });
    });

    test('picking a place ends the session; the next search gets a new '
        'token', () {
      fakeAsync((async) {
        setUpSearch();
        search.type('klcc');
        async.elapse(const Duration(milliseconds: 300));
        search
          ..endSession()
          ..type('pavilion');
        async.elapse(const Duration(milliseconds: 300));

        expect(repo.calls.map((c) => c.token), ['token-1', 'token-2']);
      });
    });

    test('no token is made until the first request', () {
      fakeAsync((async) {
        setUpSearch();
        search.type('k');
        expect(tokens, 0);
        async.elapse(const Duration(milliseconds: 250));
        expect(tokens, 1);
      });
    });
  });

  test('a slow answer to an old query never replaces a newer one', () {
    fakeAsync((async) {
      setUpSearch();
      repo.delay = const Duration(seconds: 2);
      search.type('kl');
      async.elapse(const Duration(milliseconds: 300)); // "kl" in flight
      repo.delay = Duration.zero;
      search.type('klcc');
      async
        ..elapse(const Duration(milliseconds: 300)) // "klcc" answered
        ..elapse(const Duration(seconds: 2)); // "kl" lands late

      expect(results(), ['klcc']);
    });
  });

  test('a failure can be retried', () {
    fakeAsync((async) {
      setUpSearch();
      repo.fail = true;
      search.type('klcc');
      async
        ..elapse(const Duration(milliseconds: 250))
        ..flushMicrotasks();
      expect(search.state, isA<AutocompleteFailed>());

      repo.fail = false;
      search.retry();
      async.elapse(Duration.zero);
      expect(results(), ['klcc']);
    });
  });

  test('dispose cancels a pending request', () {
    fakeAsync((async) {
      setUpSearch();
      search
        ..type('klcc')
        ..dispose();
      async.elapse(const Duration(seconds: 1));

      expect(repo.calls, isEmpty);
    });
  });

  test('states stream emits each change', () async {
    setUpSearch();
    final seen = <Type>[];
    final sub = search.states.listen((s) => seen.add(s.runtimeType));
    search.type('klcc');
    await Future<void>.delayed(const Duration(milliseconds: 300));
    await sub.cancel();

    expect(seen, [AutocompleteLoading, AutocompleteResults]);
    search.dispose();
  });
}
