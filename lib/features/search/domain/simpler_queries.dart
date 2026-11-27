/// Shorter searches to try when [query] found nothing (SearchEmpty "Try"):
/// for two words, each word; for more, consecutive pairs of words. At most
/// three, never the query itself.
// shortcut: plain word-splitting; it can't expand "Jln" to "Jalan" or
// guess "Kopitiam near me" like the canvas. Revisit with real queries.
List<String> simplerQueries(String query) {
  final words = query.trim().split(RegExp(r'\s+'));
  if (words.length < 2) return const [];
  final tries = words.length == 2
      ? words
      : [
          for (var i = 0; i + 1 < words.length; i += 2)
            '${words[i]} ${words[i + 1]}',
        ];
  return tries.take(3).toList();
}
