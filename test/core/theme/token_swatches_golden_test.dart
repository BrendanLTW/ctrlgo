@Tags(['golden'])
library;

import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_radius.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/ct_text.dart';
import 'package:ctrlgo/core/theme/ct_theme.dart';
import 'package:ctrlgo/core/theme/ct_tones.dart';
import 'package:ctrlgo/core/theme/go_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final (name, theme) in [
    ('light', buildLightTheme()),
    ('dark', buildDarkTheme()),
  ]) {
    testWidgets('token swatches, $name', (tester) async {
      tester.view
        ..physicalSize = const Size(900, 1300)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const _SwatchPage(),
        ),
      );

      await expectLater(
        find.byType(_SwatchPage),
        matchesGoldenFile('goldens/token_swatches_$name.png'),
      );
    });
  }
}

class _SwatchPage extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    final tones = context.tones;
    const toneNames = ['or', 'ye', 'gr', 'bl', 'pu', 'pk', 'rd', 'gy'];
    const radii = [
      CtRadius.r9,
      CtRadius.r13,
      CtRadius.r16,
      CtRadius.r18,
      CtRadius.r22,
      CtRadius.r24,
      CtRadius.r28,
      CtRadius.r32,
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(CtSpacing.screenX),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Label('FAMILY CORE'),
            _Swatches(c.tokens),
            const _Label('CTRLGO'),
            _Swatches(context.goColors.tokens),
            const _Label('TONES · TILE / FG / CHART'),
            Wrap(
              spacing: CtSpacing.cardGap,
              runSpacing: CtSpacing.cardGap,
              children: [
                for (final (i, t) in tones.all.indexed)
                  Column(
                    children: [
                      Container(
                        width: CtSize.tileLg,
                        height: CtSize.tileLg,
                        decoration: BoxDecoration(
                          color: t.tile,
                          borderRadius: BorderRadius.circular(CtRadius.r16),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          toneNames[i],
                          style: CtText.chip.copyWith(color: t.fg),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: CtSize.tileLg,
                        height: 8,
                        color: t.chart,
                      ),
                    ],
                  ),
              ],
            ),
            const _Label('RADIUS'),
            Wrap(
              spacing: CtSpacing.cardGap,
              children: [
                for (final r in [...radii, CtRadius.pill])
                  Container(
                    width: 72,
                    height: CtSize.tileLg,
                    decoration: BoxDecoration(
                      color: c.surface,
                      border: Border.all(color: c.border),
                      borderRadius: BorderRadius.circular(r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      r == CtRadius.pill ? 'pill' : r.toStringAsFixed(0),
                      style: CtText.meta,
                    ),
                  ),
              ],
            ),
            const _Label('TYPE'),
            for (final (name, style) in const [
              ('turnDistance 450 m', CtText.turnDistance),
              ('eta 10:42', CtText.eta),
              ('pageTitle', CtText.pageTitle),
              ('heroValue 24 min', CtText.heroValue),
              ('header', CtText.header),
              ('rowTitle', CtText.rowTitle),
              ('body 0123456789', CtText.body),
              ('meta', CtText.meta),
              ('LABEL', CtText.label),
              ('chip', CtText.chip),
              ('small', CtText.small),
            ])
              Text(name, style: style),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const new(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: CtSpacing.sectionTop, bottom: 8),
    child: Text(
      text,
      style: CtText.label.copyWith(color: context.ctColors.muted),
    ),
  );
}

class _Swatches extends StatelessWidget {
  const new(this.tokens);

  final Map<String, Color> tokens;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    return Wrap(
      spacing: CtSpacing.cardGap,
      runSpacing: CtSpacing.cardGap,
      children: [
        for (final MapEntry(:key, :value) in tokens.entries)
          SizedBox(
            width: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: value,
                    border: Border.all(color: c.border),
                    borderRadius: BorderRadius.circular(CtRadius.r13),
                  ),
                ),
                Text(key, style: CtText.small),
              ],
            ),
          ),
      ],
    );
  }
}
