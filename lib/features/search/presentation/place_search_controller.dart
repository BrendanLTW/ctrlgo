import 'dart:async';

import 'package:ctrlgo/app/dependencies.dart';
import 'package:ctrlgo/core/uuid.dart';
import 'package:ctrlgo/features/map/presentation/current_position.dart';
import 'package:ctrlgo/features/search/domain/autocomplete_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'place_search_controller.g.dart';

/// The Search screen's autocomplete. Lives as long as the screen, so
/// leaving Search ends the session.
@riverpod
class PlaceSearchController extends _$PlaceSearchController {
  late AutocompleteSearch _search;

  @override
  AutocompleteState build() {
    _search = AutocompleteSearch(
      ref.watch(placeSearchRepositoryProvider),
      newSessionToken: uuidV4,
      near: () => ref.read(currentPositionProvider).value,
    );
    final sub = _search.states.listen((s) => state = s);
    ref.onDispose(() {
      unawaited(sub.cancel());
      _search.dispose();
    });
    return _search.state;
  }

  void type(String input) => _search.type(input);

  void retry() => _search.retry();

  /// A place was picked: the next search pays for a new session.
  void endSession() => _search.endSession();
}
