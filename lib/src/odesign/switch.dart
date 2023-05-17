import 'package:flutter/material.dart';

class OSwitch extends StatelessWidget {
  const OSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.selectedIcon,
    this.unselectedIcon,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Icon? selectedIcon;
  final Icon? unselectedIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Switch(
      value: value,
      thumbIcon: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected) && selectedIcon != null) {
          return Icon(
            selectedIcon?.icon,
            color: theme.colorScheme.primary,
          );
        } else if (states.isEmpty) {
          return unselectedIcon;
        }
        return null;
      }),
      onChanged: (newValue) => onChanged(newValue),
    );
  }
}
