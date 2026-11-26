import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// The colour a style gives [feature]'s [element], or null.
String? _colour(List<dynamic> style, String feature, String element) {
  for (final rule in style.cast<Map<String, dynamic>>()) {
    if (rule['featureType'] == feature && rule['elementType'] == element) {
      for (final s in (rule['stylers'] as List).cast<Map<String, dynamic>>()) {
        if (s['color'] != null) return s['color'] as String;
      }
    }
  }
  return null;
}

void main() {
  // DESIGN §2.3: feature → (element, light, dark).
  const expected = {
    'landscape': ('geometry', '#EEF1F5', '#0F1623'),
    'landscape.man_made': ('geometry', '#E6EAF0', '#131B29'),
    'road.local': ('geometry.fill', '#FFFFFF', '#1B2433'),
    'road.arterial': ('geometry.fill', '#FFFFFF', '#263142'),
    'road.highway': ('geometry.fill', '#FFF4DA', '#3A3424'),
    'water': ('geometry', '#C7E0F7', '#0E2236'),
    'poi.park': ('geometry', '#D3EED9', '#10261B'),
    'transit.line': ('geometry', '#B7BFCC', '#2E3848'),
  };

  for (final (i, name) in ['light', 'dark'].indexed) {
    test('$name.json matches DESIGN §2.3 and hides business POIs', () {
      final style = jsonDecode(
        File('assets/map/$name.json').readAsStringSync(),
      ) as List<dynamic>;

      for (final MapEntry(key: feature, value: v) in expected.entries) {
        final (element, light, dark) = v;
        expect(
          _colour(style, feature, element),
          i == 0 ? light : dark,
          reason: '$feature $element',
        );
      }
      expect(
        style,
        contains(
          equals({
            'featureType': 'poi.business',
            'stylers': [
              {'visibility': 'off'},
            ],
          }),
        ),
      );
    });
  }
}
