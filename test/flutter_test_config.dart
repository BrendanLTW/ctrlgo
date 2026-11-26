import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Runs before every test file. Loads the bundled Poppins so goldens show
/// real glyphs instead of the test font's boxes.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final poppins = FontLoader('Poppins');
  for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
    poppins.addFont(rootBundle.load('assets/fonts/Poppins-$weight.ttf'));
  }
  await poppins.load();
  await testMain();
}
