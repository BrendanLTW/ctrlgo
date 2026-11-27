import 'package:ctrlgo/l10n/l10n.dart';
import 'package:intl/intl.dart';

/// When something happened, as the canvas writes it in list rows: "today",
/// "yesterday", "Mon" within the week, then "12 Nov". Compares local
/// calendar dates.
String relativeDay(DateTime at, DateTime now, AppLocalizations l10n) {
  final local = at.toLocal();
  final days = _date(now).difference(_date(at)).inDays;
  return switch (days) {
    <= 0 => l10n.today,
    1 => l10n.yesterday,
    < 7 => DateFormat.E(l10n.localeName).format(local),
    // Malaysian order (DESIGN §8), whatever English the locale is.
    _ => DateFormat('d MMM', l10n.localeName).format(local),
  };
}

// As UTC so a daylight-saving change can't make a day 23 hours long.
DateTime _date(DateTime t) {
  final l = t.toLocal();
  return DateTime.utc(l.year, l.month, l.day);
}
