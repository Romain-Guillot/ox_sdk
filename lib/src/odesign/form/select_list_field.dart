import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';

class OSelectItem<T> {
  const OSelectItem({
    required this.value,
    required this.label,
    this.icon,
    this.color,
  });

  final T value;
  final Widget? icon;
  final Widget label;
  final OChipColor? color;
}

class OChipColor {
  const OChipColor({
    required this.background,
    required this.strokeColor,
    required this.foreground,
  });

  final Color background;
  final Color strokeColor;
  final Color foreground;
}

class OSelectFormField<T> extends StatefulWidget {
  const OSelectFormField({
    Key? key,
    required this.field,
    required this.items,
  }) : super(key: key);

  final XSelectListField<T> field;
  final List<OSelectItem> items;

  @override
  State<OSelectFormField<T>> createState() => _OSelectFormFieldState<T>();
}

class _OSelectFormFieldState<T> extends State<OSelectFormField<T>> {
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
    return _Dropdown(
      field: widget.field,
      items: widget.items,
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  const _Dropdown({
    Key? key,
    required this.items,
    required this.field,
  }) : super(key: key);

  final XSelectListField<T> field;
  final List<OSelectItem<T>> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: theme.paddings.medium),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items.map((item) {
              final selected = field.hasItem(item.value);
              final selectedColor = item.color?.background ?? theme.colorScheme.secondary;
              final onSelectedColor = item.color?.foreground ?? theme.colorScheme.onSecondary;

              return Padding(
                padding: EdgeInsets.only(right: theme.paddings.small),
                child: ChoiceChip(
                  selected: selected,
                  onSelected: (selected) {
                    if (selected) {
                      field.addItem(item.value);
                    } else {
                      field.removeItem(item.value);
                    }
                  },
                  selectedColor: selectedColor,
                  labelStyle: TextStyle(color: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return onSelectedColor;
                    } else {
                      return theme.colorScheme.onSurface;
                    }
                  })),
                  avatar: item.icon,
                  label: item.label,
                ),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.paddings.medium),
          child: OFieldError(
            field: field,
          ),
        )
      ],
    );
  }
}

class OFieldError extends StatelessWidget {
  const OFieldError({
    super.key,
    required this.field,
  });

  final XField field;

  TextStyle errorStyle(BuildContext context) {
    final theme = Theme.of(context);
    var style = theme.inputDecorationTheme.errorStyle;
    style ??= theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.error);
    return style;
  }

  @override
  Widget build(BuildContext context) {
    final fieldErros = field.errors();
    final errorBuilder = InheritedOFormFieldErrorBuilder.of(context).builder;

    if (fieldErros != null && fieldErros.isNotEmpty) {
      return DefaultTextStyle.merge(
        style: errorStyle(context),
        child: errorBuilder(fieldErros.first),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
