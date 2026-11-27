import 'package:ctrlgo/core/db/app_database.dart';
import 'package:ctrlgo/core/time/clock.dart';
import 'package:ctrlgo/features/search/data/drift_recent_search_repository.dart';
import 'package:ctrlgo/features/search/domain/recent_search.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

class _StepClock implements Clock {
  DateTime time = DateTime.utc(2026, 11, 26, 9);

  /// Each read is a minute later, so every add has its own time.
  @override
  DateTime now() => time = time.add(const Duration(minutes: 1));
}

void main() {
  late AppDatabase db;
  late DriftRecentSearchRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = DriftRecentSearchRepository(db, _StepClock());
  });
  tearDown(() => db.close());

  Future<List<String>> labels() async => [
    for (final r in await repo.watchRecent().first)
      switch (r) {
        RecentPlace(:final label) => label,
        RecentQuery(:final query) => query,
      },
  ];

  RecentSearch place(int i) =>
      RecentSearch.place(placeId: 'p$i', label: 'Place $i');

  test('newest first', () async {
    await repo.add(place(1));
    await repo.add(const RecentSearch.query(query: 'nasi lemak'));
    await repo.add(place(2));

    expect(await labels(), ['Place 2', 'nasi lemak', 'Place 1']);
  });

  test('keeps only the newest 50', () async {
    for (var i = 1; i <= 55; i++) {
      await repo.add(place(i));
    }

    final kept = await labels();
    expect(kept, hasLength(RecentSearchRepository.cap));
    expect(kept.first, 'Place 55');
    expect(kept.last, 'Place 6', reason: 'the 5 oldest are gone');
    final rows = await db.select(db.recentSearches).get();
    expect(rows, hasLength(50), reason: 'deleted, not just hidden');
  });

  test('searching a place again moves it to the top, once', () async {
    await repo.add(place(1));
    await repo.add(place(2));
    await repo.add(place(1));

    expect(await labels(), ['Place 1', 'Place 2']);
  });

  test('a repeated phrase ignores case and spaces', () async {
    await repo.add(const RecentSearch.query(query: 'KLCC'));
    await repo.add(place(1));
    await repo.add(const RecentSearch.query(query: ' klcc '));

    expect(await labels(), ['klcc', 'Place 1']);
  });

  test('keeps the area line and the time', () async {
    await repo.add(
      const RecentSearch.place(
        placeId: 'mv',
        label: 'Mid Valley Megamall',
        secondaryText: 'Lingkaran Syed Putra',
      ),
    );

    final r = (await repo.watchRecent().first).single as RecentPlace;
    expect(r.secondaryText, 'Lingkaran Syed Putra');
    expect(r.searchedAt, DateTime.utc(2026, 11, 26, 9, 1));
  });

  test('clear removes everything', () async {
    await repo.add(place(1));
    await repo.add(place(2));
    await repo.clear();

    expect(await labels(), isEmpty);
  });

  test('watchers see adds and the cap trim', () async {
    for (var i = 1; i <= 50; i++) {
      await repo.add(place(i));
    }
    final seen = <int>[];
    final sub = repo.watchRecent().listen((r) => seen.add(r.length));
    await pumpEventQueue();
    await repo.add(place(51));
    await pumpEventQueue();
    await sub.cancel();

    expect(seen.last, 50);
  });
}
