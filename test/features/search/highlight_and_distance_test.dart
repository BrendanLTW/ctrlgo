import 'package:ctrlgo/core/format/distance.dart';
import 'package:ctrlgo/features/search/presentation/search_screen.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

const _mark = TextStyle(backgroundColor: Color(0xFFFFF0B8));

List<(String, bool)> _runs(String text, List<({int start, int end})> m) => [
  for (final s in highlightSpans(text, m, _mark)) (s.text!, s.style == _mark),
];

void main() {
  group('highlightSpans', () {
    test('marks a match in the middle', () {
      expect(_runs('Suria KLCC', [(start: 6, end: 10)]), [
        ('Suria ', false),
        ('KLCC', true),
      ]);
    });

    test('marks several matches, given in any order', () {
      expect(
        _runs('KLCC LRT KLCC', [(start: 9, end: 13), (start: 0, end: 4)]),
        [('KLCC', true), (' LRT ', false), ('KLCC', true)],
      );
    });

    test('no matches is one plain run', () {
      expect(_runs('Pavilion', const []), [('Pavilion', false)]);
    });

    test('clamps overlapping and out-of-range matches', () {
      expect(_runs('KLCC Park', [(start: 0, end: 6), (start: 3, end: 99)]), [
        ('KLCC P', true),
        ('ark', true),
      ]);
    });
  });

  group('formatDistance', () {
    for (final (m, text) in [
      (0, '0 m'),
      (846, '850 m'),
      (999, '1000 m'),
      (1000, '1.0 km'),
      (6812, '6.8 km'),
      (9960, '10.0 km'),
      (24400, '24 km'),
    ]) {
      test('$m m is "$text"', () => expect(formatDistance(m), text));
    }
  });
}
