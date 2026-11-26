import 'package:ctrlgo/app/app.dart';
import 'package:ctrlgo/app/app_shell.dart';
import 'package:ctrlgo/app/router.dart';
import 'package:ctrlgo/core/widgets/ct_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// A long list per tab so scroll position has something to keep.
Widget _longList(AppTab tab) => Scaffold(
  body: ListView.builder(
    key: ValueKey('list-${tab.name}'),
    itemCount: 100,
    itemBuilder: (_, i) => SizedBox(height: 60, child: Text('${tab.name} $i')),
  ),
);

Future<void> _pumpShell(WidgetTester tester) async {
  tester.view
    ..physicalSize = const Size(390, 844)
    ..devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appRouterProvider.overrideWithValue(buildRouter(tabRoot: _longList)),
      ],
      child: const CtrlGoApp(),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _tapTab(WidgetTester tester, String label) async {
  await tester.tap(find.bySemanticsLabel(label));
  await tester.pumpAndSettle();
}

double _offset(WidgetTester tester, AppTab tab) => tester
    .state<ScrollableState>(
      find.descendant(
        of: find.byKey(ValueKey('list-${tab.name}')),
        matching: find.byType(Scrollable),
      ),
    )
    .position
    .pixels;

String _fabLabel(WidgetTester tester) =>
    tester.widget<CtFab>(find.byType(CtFab)).label;

void main() {
  testWidgets('switches tabs and shows each tab root', (tester) async {
    final semantics = tester.ensureSemantics();
    await _pumpShell(tester);

    expect(find.text('explore 0'), findsOneWidget);
    for (final (label, tab) in [
      ('Friends', AppTab.friends),
      ('Saved', AppTab.saved),
      ('Profile', AppTab.profile),
      ('Explore', AppTab.explore),
    ]) {
      await _tapTab(tester, label);
      expect(find.text('${tab.name} 0'), findsOneWidget);
    }
    semantics.dispose();
  });

  testWidgets('each tab keeps its scroll position', (tester) async {
    final semantics = tester.ensureSemantics();
    await _pumpShell(tester);

    await tester.drag(
      find.byKey(const ValueKey('list-explore')),
      const Offset(0, -900),
    );
    await tester.pumpAndSettle();
    final exploreOffset = _offset(tester, AppTab.explore);
    expect(exploreOffset, greaterThan(0));

    await _tapTab(tester, 'Saved');
    await tester.drag(
      find.byKey(const ValueKey('list-saved')),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    final savedOffset = _offset(tester, AppTab.saved);

    await _tapTab(tester, 'Explore');
    expect(_offset(tester, AppTab.explore), exploreOffset);

    await _tapTab(tester, 'Saved');
    expect(_offset(tester, AppTab.saved), savedOffset);
    semantics.dispose();
  });

  testWidgets('the FAB changes per tab', (tester) async {
    final semantics = tester.ensureSemantics();
    await _pumpShell(tester);

    expect(_fabLabel(tester), 'Get directions');
    await _tapTab(tester, 'Friends');
    expect(_fabLabel(tester), 'Share my location');
    await _tapTab(tester, 'Saved');
    expect(_fabLabel(tester), 'Add a saved place');
    await _tapTab(tester, 'Profile');
    expect(_fabLabel(tester), 'Get directions');
    semantics.dispose();
  });

  testWidgets('only the selected tab shows its label', (tester) async {
    await _pumpShell(tester);

    // Visible nav text; tab roots here are lists, not titles.
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Friends'), findsNothing);
  });

  testWidgets('renders in dark mode', (tester) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    await _pumpShell(tester);

    expect(tester.takeException(), isNull);
    expect(find.byType(CtFab), findsOneWidget);
  });
}
