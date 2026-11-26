import 'dart:io';

import 'package:ctrlgo/core/widgets/ct_icon.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every icon has an SVG whose stroke can be swapped', () {
    for (final icon in CtIcon.values) {
      final svg = File(icon.asset).readAsStringSync();
      expect(svg, contains('viewBox="0 0 24 24"'), reason: icon.name);
      // CtIconView replaces this to set the stroke per use.
      expect(svg, contains('stroke-width="2"'), reason: icon.name);
    }
  });
}
