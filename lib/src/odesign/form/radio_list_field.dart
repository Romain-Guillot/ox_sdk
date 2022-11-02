import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';


enum RadioFormFieldType {
  list,
  dropdown
}


const _kDefaultNullItem = ORadioItem(value: null, label: Text('N/A'));

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
    this.hint,
    this.controlAffinity = ListTileControlAffinity.trailing,
    this.label,
    this.allowNullValue = false
  }) : super(key: key);

  final RadioFormFieldType type;
  final XRadioListField<T> field;
  final List<ORadioItem> items;
  final ListTileControlAffinity controlAffinity; // only for radios
  final Widget? hint; // only for dropdown
  final Widget? label;
  final bool allowNullValue;

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
              controlAffinity: widget.controlAffinity,
              items: widget.items,
              allowNullValue: widget.allowNullValue,
            );
          case RadioFormFieldType.dropdown:
            return _Dropdown(
              fontStyle: fontStyle, 
              selectedColor: selectedColor,
              field: widget.field,
              items: widget.items,
              hint: widget.hint,
              label: widget.label,
              allowNullValue: widget.allowNullValue,
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
    required this.field,
    required this.controlAffinity,
    this.label,
    required this.allowNullValue
  }) : super(key: key);


  final TextStyle? fontStyle;
  final Color? selectedColor;
  final XRadioListField<T> field;
  final List<ORadioItem> items;
  final ListTileControlAffinity controlAffinity;
  final Widget? label;
  final bool allowNullValue;

  @override
  Widget build(BuildContext context) {
    final effectiveItems = allowNullValue ? [_kDefaultNullItem, ...items] : items;

    return OCard(
      hasContentPadding: false,
      child: Column(
        children: effectiveItems.map((item) {
          final isSelected = item.value == field.value;
          final effectiveFontStyle = fontStyle?.copyWith(
            color: isSelected ? selectedColor : null 
          );
          return RadioListTile<T>(
            controlAffinity: controlAffinity,
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: item.label
              )
            ),
            onChanged: (newValue) {
              field.setValue(newValue);
            }
          );
        }).toList(),
      ),
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
    this.hint,
    this.label,
    required this.allowNullValue
  }) : super(key: key);


  final Widget? hint;
  final TextStyle? fontStyle;
  final Color? selectedColor;
  final XRadioListField<T> field;
  final List<ORadioItem<T>> items;
  final Widget? label;
  final bool allowNullValue;

  @override
  Widget build(BuildContext context) {
    final effectiveItems = allowNullValue ? [_kDefaultNullItem, ...items] : items;

    return OCard(
      hasContentPadding: true,
      contentPadding: EdgeInsets.only(
        left: Theme.of(context).paddings.medium
      ),
      child: Row(
        children: [
          if (label != null)...[
            Align(
              alignment: Alignment.centerRight,
              child: DefaultTextStyle.merge(
                style: Theme.of(context).inputDecorationTheme.labelStyle,
                child: label!
              )
            ),
            PaddingSpacer(),
          ],

          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: field.value,
                onChanged: (newValue) {
                  field.setValue(newValue);
                },
                hint: hint == null ? null :DefaultTextStyle.merge(
                  style: Theme.of(context).inputDecorationTheme.hintStyle,
                  child: hint!
                ),
                items: effectiveItems.map((e) {
                  return DropdownMenuItem(
                    value: e.value,
                    child: DefaultTextStyle.merge(
                      style: fontStyle,
                      child: e.label
                    ),
                  );
                }).toList(), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}



