import 'package:ctrlgo/core/db/app_database.dart';
import 'package:ctrlgo/core/time/clock.dart';
import 'package:ctrlgo/features/search/domain/recent_search.dart';
import 'package:drift/drift.dart';

class DriftRecentSearchRepository implements RecentSearchRepository {
  new(this._db, this._clock);

  final AppDatabase _db;
  final Clock _clock;

  $RecentSearchesTable get _t => _db.recentSearches;

  @override
  Stream<List<RecentSearch>> watchRecent() =>
      (_db.select(_t)
            ..orderBy([
              (r) => OrderingTerm.desc(r.searchedAt),
              // Same instant (fast taps): the later insert is newer.
              (r) => OrderingTerm.desc(r.id),
            ])
            ..limit(RecentSearchRepository.cap))
          .watch()
          .map((rows) => rows.map(_toDomain).toList());

  @override
  Future<void> add(RecentSearch search) => _db.transaction(() async {
    final now = _clock.now().toUtc();
    switch (search) {
      case RecentPlace(:final placeId, :final label, :final secondaryText):
        await (_db.delete(_t)..where((r) => r.placeId.equals(placeId))).go();
        await _db
            .into(_t)
            .insert(
              RecentSearchesCompanion.insert(
                placeId: Value(placeId),
                label: label,
                secondaryText: Value(secondaryText),
                searchedAt: now,
              ),
            );
      case RecentQuery(:final query):
        final trimmed = query.trim();
        await (_db.delete(
          _t,
        )..where((r) => r.query.lower().equals(trimmed.toLowerCase()))).go();
        await _db
            .into(_t)
            .insert(
              RecentSearchesCompanion.insert(
                query: Value(trimmed),
                label: trimmed,
                searchedAt: now,
              ),
            );
    }
    // Keep only the newest [cap] rows.
    await _db.customUpdate(
      'DELETE FROM recent_searches WHERE id NOT IN ( '
      'SELECT id FROM recent_searches '
      'ORDER BY searched_at DESC, id DESC LIMIT ?)',
      variables: [Variable.withInt(RecentSearchRepository.cap)],
      updates: {_t},
      updateKind: UpdateKind.delete,
    );
  });

  @override
  Future<void> clear() => _db.delete(_t).go();

  RecentSearch _toDomain(RecentSearchRow r) => switch (r.placeId) {
    final id? => RecentSearch.place(
      placeId: id,
      label: r.label,
      secondaryText: r.secondaryText,
      searchedAt: r.searchedAt,
    ),
    null => RecentSearch.query(
      query: r.query ?? r.label,
      searchedAt: r.searchedAt,
    ),
  };
}
