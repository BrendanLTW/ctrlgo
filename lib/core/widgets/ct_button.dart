import 'package:ctrlgo/core/theme/ct_colors.dart';
import 'package:ctrlgo/core/theme/ct_radius.dart';
import 'package:ctrlgo/core/theme/ct_spacing.dart';
import 'package:ctrlgo/core/theme/ct_text.dart';
import 'package:flutter/material.dart';

/// Full-width ink button (canvas `.btn`).
class CtButton extends StatelessWidget {
  const new({required this.label, required this.onPressed, super.key});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final c = context.ctColors;
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: c.ink,
        foregroundColor: c.onInk,
        minimumSize: const Size.fromHeight(CtSize.button),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CtRadius.r22),
        ),
        textStyle: CtText.button,
      ),
      child: Text(label),
    );
  }
}

/// Plain text action under a button (canvas `.link`).
class CtTextButton extends StatelessWidget {
  const new({required this.label, required this.onPressed, super.key});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: context.ctColors.ink,
        minimumSize: const Size.fromHeight(CtSize.textButton),
        textStyle: CtText.rowTitle,
      ),
      child: Text(label),
    );
  }
}
