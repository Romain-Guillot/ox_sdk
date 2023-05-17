import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';

class ODateFormField extends StatefulWidget {
  const ODateFormField({
    Key? key,
    this.label,
    required this.field,
    this.size,
    this.layout,
    this.expandField = false,
    this.decorated = true,
    required this.buttonLabel,
  }) : super(key: key);

  final XDateField field;
  final Widget? label;
  final double? size;
  final LayoutDensity? layout;
  final bool expandField;
  final bool decorated;
  final Widget buttonLabel;

  @override
  State<ODateFormField> createState() => _ODateFormFieldState();
}

class _ODateFormFieldState extends State<ODateFormField> {
  late ValueChanged listener;

  @override
  void initState() {
    super.initState();
    listener = (value) {
      if (mounted) {
        setState(() {});
      }
    };
    widget.field.addListener(listener);
  }

  @override
  void dispose() {
    widget.field.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hintStyle = theme.inputDecorationTheme.hintStyle;
    final textStyle = theme.textTheme.titleMedium;
    final selectedDate = widget.field.value?.format(context, DateFormatType.writtenDate);

    Widget child;
    if (selectedDate == null) {
      child = DefaultTextStyle.merge(
        style: hintStyle,
        child: widget.buttonLabel,
      );
    } else {
      child = Text(
        selectedDate,
        style: textStyle,
      );
    }

    child = SizedBox(
      width: double.infinity,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: Theme.of(context).radiuses.medium,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.fromMicrosecondsSinceEpoch(0),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              widget.field.setValue(date);
            }
          },
          child: Padding(
            padding: theme.inputDecorationTheme.contentPadding ?? const EdgeInsets.only(),
            child: child,
          ),
        ),
      ),
    );
    if (widget.decorated) {
      child = OFormField(
        label: widget.label,
        fieldSize: widget.size,
        layout: widget.layout,
        expandField: widget.expandField,
        errors: widget.field.errors(),
        child: child,
      );
    }
    return child;
  }
}
