import 'package:drift/drift.dart';

/// PRD §7 RecentSearch: a picked place or a searched phrase.
@DataClassName('RecentSearchRow')
class RecentSearches extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Set for a picked place.
  TextColumn get placeId => text().nullable()();

  /// Set for a searched phrase.
  TextColumn get query => text().nullable()();

  TextColumn get label => text()();
  TextColumn get secondaryText => text().withDefault(const Constant(''))();

  /// UTC.
  DateTimeColumn get searchedAt => dateTime()();
}
