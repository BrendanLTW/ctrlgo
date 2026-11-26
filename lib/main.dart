import 'package:ctrlgo/app/app.dart';
import 'package:ctrlgo/app/env.dart';
import 'package:ctrlgo/app/maps_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await loadMapsScript(Env.mapsApiKey);
  } on Object catch (e) {
    // Offline or blocked: start anyway; only the map is missing.
    debugPrint('$e');
  }
  runApp(const ProviderScope(child: CtrlGoApp()));
}
