import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/widgets/ct_fab.dart';
import 'package:ctrlgo/core/widgets/ct_nav_bar.dart';
import 'package:ctrlgo/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The four tabs, in nav order. Their index is the shell branch index.
enum AppTab {
  explore('/explore'),
  friends('/friends'),
  saved('/saved'),
  profile('/profile');

  new(this.path);

  final String path;

  String label(AppLocalizations l10n) => switch (this) {
    explore => l10n.tabExplore,
    friends => l10n.tabFriends,
    saved => l10n.tabSaved,
    profile => l10n.tabProfile,
  };
}

/// Hosts the tab branches with the floating nav and the tab's FAB on top.
class AppShell extends StatelessWidget {
  const new({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final tab = AppTab.values[shell.currentIndex];
    // Sit 24 px up as drawn, but never inside the system gesture/nav area.
    final bottom = MediaQuery.viewPaddingOf(context).bottom
        .clamp(CtSize.navBottom, double.infinity);

    return Scaffold(
      body: Stack(
        children: [
          shell,
          Positioned(
            left: CtSpacing.screenX,
            right: CtSpacing.screenX,
            bottom: bottom,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CtNavBar(
                  semanticLabel: l10n.mainNavigation,
                  selectedIndex: shell.currentIndex,
                  onSelected: (i) => shell.goBranch(
                    i,
                    // Tapping the current tab returns it to its root.
                    initialLocation: i == shell.currentIndex,
                  ),
                  items: [
                    for (final t in AppTab.values)
                      CtNavItem(icon: _navIcons[t]!, label: t.label(l10n)),
                  ],
                ),
                _fabFor(tab, l10n),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // shortcut: actions are no-ops until Search (1.3), PlaceEdit (1.5) and
  // ShareSheet (3.4) exist; wire each when its screen lands.
  CtFab _fabFor(AppTab tab, AppLocalizations l10n) => switch (tab) {
    AppTab.explore || AppTab.profile => CtFab(
      icon: Icons.near_me,
      label: l10n.getDirections,
      onPressed: () {},
    ),
    AppTab.friends => CtFab(
      icon: Icons.ios_share,
      label: l10n.shareMyLocation,
      onPressed: () {},
    ),
    AppTab.saved => CtFab(
      icon: Icons.add,
      label: l10n.addSavedPlace,
      onPressed: () {},
    ),
  };
}

// shortcut: Material icons stand in for the canvas's 1.7 px stroke icons
// until we bundle SVGs (needs flutter_svg).
const Map<AppTab, IconData> _navIcons = {
  AppTab.explore: Icons.explore_outlined,
  AppTab.friends: Icons.people_outline,
  AppTab.saved: Icons.bookmark_border,
  AppTab.profile: Icons.person_outline,
};
