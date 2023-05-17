import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/form/form_field.dart';
import 'package:ox_sdk/src/odesign/themings/theme.dart';
import 'package:ox_sdk/src/utils/common/distance.dart';
import 'package:ox_sdk/src/xframework/form/form.dart';

class ODistanceFormField extends StatefulWidget {
  const ODistanceFormField({
    Key? key,
    this.label,
    this.hint,
    required this.field,
    this.size,
    this.style,
    this.layout,
    this.expandField = false,
  }) : super(key: key);

  final XDistanceField field;
  final Widget? label;
  final String? hint;
  final double? size;
  final TextStyle? style;
  final LayoutDensity? layout;
  final bool expandField;

  @override
  State<ODistanceFormField> createState() => _ODistanceFormFieldState();
}

class _ODistanceFormFieldState extends State<ODistanceFormField> {
  late ValueChanged<DistanceFieldValue?> callback;

  @override
  void initState() {
    super.initState();
    callback = (value) {
      setState(() {});
    };
    widget.field.addListener(callback);
  }

  @override
  void dispose() {
    widget.field.removeListener(callback);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OFormField(
      label: widget.label,
      fieldSize: widget.size,
      layout: widget.layout,
      expandField: widget.expandField,
      errors: widget.field.errors(),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.field.valueController,
                decoration: InputDecoration(
                  hintText: widget.hint ?? 'Distance',
                ),
              ),
            ),
            VerticalDivider(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              thickness: 2,
              endIndent: 13,
              indent: 13,
            ),
            DropdownButton<DistanceUnit>(
              onChanged: (value) {
                widget.field.setValue(widget.field.value.copyWith(unit: value));
              },
              underline: Container(),
              value: widget.field.unit,
              items: DistanceUnit.values
                  .map((unit) => DropdownMenuItem<DistanceUnit>(
                        value: unit,
                        child: Text(unit.name),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
