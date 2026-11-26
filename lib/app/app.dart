import 'package:ctrlgo/app/router.dart';
import 'package:ctrlgo/core/theme/ct_theme.dart';
import 'package:ctrlgo/core/theme/theme_mode_controller.dart';
import 'package:ctrlgo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CtrlGoApp extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      onGenerateTitle: (context) => 'ctrlGo',
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ref.watch(themeModeControllerProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(appRouterProvider),
    );
  }
}
