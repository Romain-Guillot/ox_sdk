import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/form/form_field.dart';
import 'package:ox_sdk/src/odesign/themings/theme.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/xframework/form/form.dart';

class ODurationFormFieldLabels {
  const ODurationFormFieldLabels({
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final String hours;
  final String minutes;
  final String seconds;
}

class ODurationFormField extends StatefulWidget {
  const ODurationFormField({
    Key? key,
    required this.field,
    this.label,
    this.size,
    this.style,
    this.layout,
    this.expandField = false,
    this.labelStyle,
    required this.labels,
  }) : super(key: key);

  final XDurationField field;
  final Widget? label;
  final double? size;
  final TextStyle? style;
  final LayoutDensity? layout;
  final bool expandField;
  final TextStyle? labelStyle;
  final ODurationFormFieldLabels labels;

  @override
  State<ODurationFormField> createState() => _ODurationFormFieldState();
}

class _ODurationFormFieldState extends State<ODurationFormField> {
  late ValueChanged<Duration?> callback;

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
      labelStyle: widget.labelStyle,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: TextField(
            controller: widget.field.hoursController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: widget.labels.hours,
            ),
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Theme.of(context).paddings.small),
            child: Text(':', style: Theme.of(context).textTheme.displaySmall),
          ),
          Flexible(
              child: TextField(
            controller: widget.field.minutesController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: widget.labels.minutes,
            ),
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Theme.of(context).paddings.small),
            child: Text(':', style: Theme.of(context).textTheme.displaySmall),
          ),
          Flexible(
              child: TextField(
            controller: widget.field.secondsController,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: widget.labels.seconds,
            ),
          )),
        ],
      ),
    );
  }
}
