import 'package:ctrlgo/core/theme/ct_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: const Scaffold(body: Center(child: Text('ctrlGo'))),
    );
  }
}
