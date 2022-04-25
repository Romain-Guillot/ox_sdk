
import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';


class OTextFormField extends StatelessWidget {
  const OTextFormField({
    Key? key,
    required this.label,
    this.hint,
    required this.field,
    this.size
  }) : super(key: key);

  final XTextField field;
  final Widget label;
  final String? hint;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return OFormField(
      label: label,
      fieldSize: size,
      errors: field.errors()?.map(Text.new).toList(),
      child: TextField(
        controller: field.controller,
        decoration: InputDecoration(
          hintText: hint
        ),
      )
    );
  }
}

