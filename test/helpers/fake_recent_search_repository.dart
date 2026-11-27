import 'dart:async';

import 'package:ctrlgo/features/search/domain/recent_search.dart';

/// In-memory recents for widget tests; the cap and ordering are proven
/// against SQLite in `drift_recent_search_repository_test.dart`.
class FakeRecentSearchRepository implements RecentSearchRepository {
  new([List<RecentSearch> initial = const []]) : items = [...initial];

  final List<RecentSearch> items;
  final _changes = StreamController<List<RecentSearch>>.broadcast();

  @override
  Stream<List<RecentSearch>> watchRecent() async* {
    yield List.of(items);
    yield* _changes.stream;
  }

  @override
  Future<void> add(RecentSearch search) async {
    items.insert(0, search);
    _changes.add(List.of(items));
  }

  @override
  Future<void> clear() async {
    items.clear();
    _changes.add(const []);
  }
}
