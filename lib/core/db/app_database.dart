import 'package:ctrlgo/core/db/tables.dart';
import 'package:drift/drift.dart';

part 'app_database.g.dart';

/// On-device data (PRD §7): saved places, collections, recents, offline
/// areas. Tests open it in memory with `NativeDatabase.memory()`.
@DriftDatabase(tables: [RecentSearches])
class AppDatabase extends _$AppDatabase {
  new(super.e);

  @override
  int get schemaVersion => 1;
}
