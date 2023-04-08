import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';

class OTextFormField extends StatelessWidget {
  const OTextFormField({
    Key? key,
    this.label,
    this.hint,
    required this.field,
    this.size,
    this.style,
    this.layout,
    this.expandField = false,
    this.textAlign = TextAlign.start,
    this.minLines = 1,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.decorated = true,
    this.decoration,
  }) : super(key: key);

  final XTextField field;
  final Widget? label;
  final String? hint;
  final double? size;
  final TextStyle? style;
  final LayoutDensity? layout;
  final bool expandField;
  final TextAlign textAlign;
  final int minLines;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final InputDecoration? decoration;
  final bool decorated;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget child = TextField(
      controller: field.controller,
      style: style,
      textAlign: textAlign,
      minLines: minLines,
      textCapitalization: textCapitalization,
      maxLines: max(maxLines, minLines),
      decoration: decoration?.copyWith(
            hintText: hint,
            hintStyle: theme.inputDecorationTheme.hintStyle?.copyWith(
              fontSize: style?.fontSize,
            ),
          ) ??
          InputDecoration(
            hintText: hint,
          ),
    );

    if (decorated) {
      child = OFormField(
        label: label,
        fieldSize: size,
        layout: layout,
        expandField: expandField,
        errors: field.errors()?.map(Text.new).toList(),
        child: Padding(
          padding: minLines > 1 ? EdgeInsets.symmetric(vertical: Theme.of(context).paddings.medium) : EdgeInsets.zero,
          child: child,
        ),
      );
    }

    return child;
  }
}
