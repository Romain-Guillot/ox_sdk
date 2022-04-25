import 'package:flutter/material.dart';
import 'package:ox_sdk/src/xframework/form/form.dart';


class ORadioItem<T> {
  const ORadioItem({
    required this.value,
    this.icon,
    required this.label
  });

  final T value;
  final Widget? icon;
  final Widget label;
}


class ORadioFormField<T> extends StatefulWidget {
  const ORadioFormField({
    Key? key,
    required this.field,
    required this.items
  }) : super(key: key);

  final XRadioListField<T> field;
  final List<ORadioItem> items;

  @override
  State<ORadioFormField<T>> createState() => _ORadioFormFieldState<T>();
}

class _ORadioFormFieldState<T> extends State<ORadioFormField<T>> {

  late ValueChanged listener;

  @override
  void initState() {
    super.initState();
    listener = (value) {
      if (mounted) {
        setState(() { });
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
    final fontStyle = Theme.of(context).textTheme.bodyLarge;
    final selectedColor = Theme.of(context).radioTheme.fillColor?.resolve({MaterialState.selected});
    return  Builder(
      builder: (context) {
        return  Column(
          children: widget.items.map((item) {
            final isSelected = item.value == widget.field.value;
            final effectiveFontStyle = fontStyle?.copyWith(
              color: isSelected ? selectedColor : null 
            );
            return RadioListTile<T>(
              controlAffinity: ListTileControlAffinity.trailing,
              value: item.value, 
              selected: isSelected,
              secondary: item.icon == null ? null : IconTheme(
                data: IconThemeData(
                  size: 24,
                  color: effectiveFontStyle?.color
                ),
                child: item.icon!
              ),
              
              groupValue: widget.field.value, 
              title: DefaultTextStyle.merge(
              style: effectiveFontStyle,
              child: item.label),
              onChanged: (newValue) {
                widget.field.setValue(newValue);
              }
            );
          }).toList(),
        );
      }
    );
  }
}