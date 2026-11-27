import 'package:ctrlgo/core/format/relative_day.dart';
import 'package:ctrlgo/features/search/domain/simpler_queries.dart';
import 'package:ctrlgo/l10n/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  group('simplerQueries', () {
    test('one word has nothing simpler', () {
      expect(simplerQueries('klcc'), isEmpty);
      expect(simplerQueries('   '), isEmpty);
    });

    test('two words: each word', () {
      expect(simplerQueries('Lai Foong'), ['Lai', 'Foong']);
    });

    test('more words: pairs, at most three', () {
      expect(simplerQueries('Kedai Kopi Lai Foong Jln Tun HS'), [
        'Kedai Kopi',
        'Lai Foong',
        'Jln Tun',
      ]);
      expect(simplerQueries('Nasi Kandar Pelita'), ['Nasi Kandar']);
    });

    test('extra spaces are ignored', () {
      expect(simplerQueries('  Lai   Foong '), ['Lai', 'Foong']);
    });
  });

  group('relativeDay', () {
    // The app's localization delegates load this; a unit test must.
    setUpAll(() => initializeDateFormatting('en'));
    final l10n = AppLocalizationsEn();
    final now = DateTime(2026, 11, 26, 9, 41); // a Thursday

    for (final (at, text) in [
      (DateTime(2026, 11, 26, 0, 5), 'today'),
      (DateTime(2026, 11, 25, 23, 59), 'yesterday'),
      (DateTime(2026, 11, 23, 12), 'Mon'),
      (DateTime(2026, 11, 20, 12), 'Fri'),
      (DateTime(2026, 11, 19, 12), '19 Nov'),
    ]) {
      test('$at is "$text"', () => expect(relativeDay(at, now, l10n), text));
    }
  });
}
