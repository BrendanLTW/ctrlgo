import 'package:freezed_annotation/freezed_annotation.dart';

part 'recent_search.freezed.dart';

/// A place the user picked, or a phrase they searched (PRD §7).
@freezed
sealed class RecentSearch with _$RecentSearch {
  const factory place({
    required String placeId,
    required String label,
    @Default('') String secondaryText,
    DateTime? searchedAt,
  }) = RecentPlace;

  const factory query({required String query, DateTime? searchedAt}) =
      RecentQuery;
}

abstract interface class RecentSearchRepository {
  /// Keep only this many, newest first (PRD §7).
  static const cap = 50;

  /// Newest first.
  Stream<List<RecentSearch>> watchRecent();

  /// Adds [search] as the newest. Searching the same place or phrase again
  /// moves it to the top rather than repeating it.
  Future<void> add(RecentSearch search);

  Future<void> clear();
}
