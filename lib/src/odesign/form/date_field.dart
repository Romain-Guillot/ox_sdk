import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';

class ODateFormField extends StatelessWidget {
  const ODateFormField({
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
  }) : super(key: key);

  final XDateField field;
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

  @override
  Widget build(BuildContext context) {
    return OFormField(
      label: label,
      fieldSize: size,
      layout: layout,
      expandField: expandField,
      errors: field.errors()?.map(Text.new).toList(),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              field.setValue(date);
            }
          },
          child: Text("DATE"),
        ),
      ),
    );
  }
}
