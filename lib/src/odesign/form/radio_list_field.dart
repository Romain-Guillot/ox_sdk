import 'package:flutter/material.dart';
import 'package:ox_sdk/src/xframework/form/form.dart';


enum RadioFormFieldType {
  list,
  dropdown
}

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
    required this.items,
    this.type = RadioFormFieldType.list,
    this.hint
  }) : super(key: key);

  final RadioFormFieldType type;
  final XRadioListField<T> field;
  final List<ORadioItem> items;
  final Widget? hint; // only for dropdown

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
        switch (widget.type) {
          case RadioFormFieldType.list:
            return _RadioList(
              fontStyle: fontStyle, 
              selectedColor: selectedColor,
              field: widget.field,
              items: widget.items,
            );
          case RadioFormFieldType.dropdown:
            return _Dropdown(
              fontStyle: fontStyle, 
              selectedColor: selectedColor,
              field: widget.field,
              items: widget.items,
              hint: widget.hint,
            );
        }
      }
    );
  }
}

class _RadioList<T> extends StatelessWidget {
  const _RadioList({
    Key? key,
    required this.fontStyle,
    required this.selectedColor,
    required this.items,
    required this.field
  }) : super(key: key);


  final TextStyle? fontStyle;
  final Color? selectedColor;
  final XRadioListField<T> field;
  final List<ORadioItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        final isSelected = item.value == field.value;
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
          
          groupValue: field.value, 
          title: DefaultTextStyle.merge(
          style: effectiveFontStyle,
          child: item.label),
          onChanged: (newValue) {
            field.setValue(newValue);
          }
        );
      }).toList(),
    );
  }
}



class _Dropdown<T> extends StatelessWidget {
  const _Dropdown({
    Key? key,
    required this.fontStyle,
    required this.selectedColor,
    required this.items,
    required this.field,
    this.hint
  }) : super(key: key);


  final Widget? hint;
  final TextStyle? fontStyle;
  final Color? selectedColor;
  final XRadioListField<T> field;
  final List<ORadioItem<T>> items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        value: field.value,
        onChanged: (newValue) {
          field.setValue(newValue);
        },
        hint: hint == null ? null :DefaultTextStyle.merge(
          style: Theme.of(context).inputDecorationTheme.hintStyle,
          child: hint!
        ),
        items: items.map((e) => DropdownMenuItem(
          value: e.value,
          child: e.label,
        )).toList(), 
      ),
    );
  }
}



