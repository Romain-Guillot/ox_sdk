import 'package:flutter/material.dart';

class OTrailingNotification extends StatelessWidget {
  const OTrailingNotification({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CircleAvatar(
      radius: 10,
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
      child: DefaultTextStyle.merge(
        style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold),
        child: child,
      ),
    );
  }
}
