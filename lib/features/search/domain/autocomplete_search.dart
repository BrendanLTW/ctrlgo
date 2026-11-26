import 'dart:async';

import 'package:ctrlgo/core/location/geo_position.dart';
import 'package:ctrlgo/features/search/domain/place_search_repository.dart';
import 'package:ctrlgo/features/search/domain/place_suggestion.dart';

/// What the search screen shows for the current query.
sealed class AutocompleteState {
  const new(this.query);
  final String query;
}

class AutocompleteIdle extends AutocompleteState {
  const new() : super('');
}

class AutocompleteLoading extends AutocompleteState {
  const new(super.query, {this.previous = const []});

  /// Results for the last query, kept on screen while the next one loads.
  final List<PlaceSuggestion> previous;
}

class AutocompleteResults extends AutocompleteState {
  const new(super.query, this.suggestions);
  final List<PlaceSuggestion> suggestions;
}

class AutocompleteFailed extends AutocompleteState {
  const new(super.query);
}

/// One search session: debounces typing, reuses a session token until a
/// place is picked or the search is abandoned, and drops answers to queries
/// the user has already typed past.
class AutocompleteSearch {
  new(
    this._repo, {
    required this._newSessionToken,
    GeoPosition? Function()? near,
    this.debounce = const Duration(milliseconds: 250),
  }) : _near = near ?? (() => null);

  final PlaceSearchRepository _repo;
  final String Function() _newSessionToken;
  final GeoPosition? Function() _near;
  final Duration debounce;

  final _states = StreamController<AutocompleteState>.broadcast();
  Stream<AutocompleteState> get states => _states.stream;
  AutocompleteState _state = const AutocompleteIdle();
  AutocompleteState get state => _state;

  String? _sessionToken;
  Timer? _timer;
  int _latest = 0;

  /// The token the next request will use; created on first use.
  String get sessionToken => _sessionToken ??= _newSessionToken();

  void type(String input) {
    _timer?.cancel();
    final query = input.trim();
    _latest++;
    if (query.isEmpty) return _emit(const AutocompleteIdle());

    final previous = switch (_state) {
      AutocompleteResults(:final suggestions) => suggestions,
      AutocompleteLoading(:final previous) => previous,
      _ => const <PlaceSuggestion>[],
    };
    _emit(AutocompleteLoading(query, previous: previous));
    _timer = Timer(debounce, () => _fetch(query));
  }

  /// Retries the current query at once, e.g. after a failure.
  void retry() {
    if (_state.query.isNotEmpty) unawaited(_fetch(_state.query));
  }

  /// Ends the session (a place was picked or the search closed); the next
  /// keystroke starts a new one with a fresh token.
  void endSession() => _sessionToken = null;

  void dispose() {
    _timer?.cancel();
    unawaited(_states.close());
  }

  Future<void> _fetch(String query) async {
    final request = ++_latest;
    try {
      final results = await _repo.autocomplete(
        query,
        sessionToken: sessionToken,
        near: _near(),
      );
      if (request == _latest) _emit(AutocompleteResults(query, results));
    } on Object {
      if (request == _latest) _emit(AutocompleteFailed(query));
    }
  }

  void _emit(AutocompleteState s) {
    _state = s;
    if (!_states.isClosed) _states.add(s);
  }
}
