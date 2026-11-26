import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'helpers/fake_maps_platform.dart';

/// Runs before every test file. Loads the bundled Poppins so goldens show
/// real glyphs instead of the test font's boxes, and swaps the native map
/// for a fake.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final poppins = FontLoader('Poppins');
  for (final weight in ['Regular', 'Medium', 'SemiBold', 'Bold']) {
    poppins.addFont(rootBundle.load('assets/fonts/Poppins-$weight.ttf'));
  }
  await poppins.load();
  GoogleMapsFlutterPlatform.instance = FakeMapsPlatform();
  await testMain();
}
