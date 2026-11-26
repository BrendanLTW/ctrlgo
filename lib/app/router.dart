import 'package:ctrlgo/app/app_shell.dart';
import 'package:ctrlgo/core/theme/ct_text.dart';
import 'package:ctrlgo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) => buildRouter();

/// [tabRoot] builds each tab's first screen; tests swap in their own.
GoRouter buildRouter({Widget Function(AppTab tab) tabRoot = _placeholder}) {
  return GoRouter(
    initialLocation: AppTab.explore.path,
    routes: [
      // indexedStack keeps every tab alive, so each keeps its scroll
      // position and navigation stack while another tab is showing.
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          for (final tab in AppTab.values)
            StatefulShellBranch(
              routes: [
                GoRoute(path: tab.path, builder: (_, _) => tabRoot(tab)),
              ],
            ),
        ],
      ),
    ],
  );
}

// shortcut: placeholder until each tab's real screen lands (Explore 1.2,
// Saved 1.5, Friends 3.3, Profile later).
Widget _placeholder(AppTab tab) => Builder(
  builder: (context) => Scaffold(
    body: Center(child: Text(tab.label(context.l10n), style: CtText.pageTitle)),
  ),
);
