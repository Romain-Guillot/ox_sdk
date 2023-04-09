import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';

class ONotificationBadge extends StatelessWidget {
  const ONotificationBadge({
    super.key,
    required this.notification,
    required this.child,
  });

  final Widget notification;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return badges.Badge(
      position: badges.BadgePosition.topEnd(
        end: 3,
        top: 3,
      ),
      badgeStyle: badges.BadgeStyle(
        padding: const EdgeInsets.all(2.0),
        badgeColor: theme.colors.error,
      ),
      badgeContent: IconTheme.merge(
          data: IconThemeData(
            size: 14,
            color: theme.colors.onError,
          ),
          child: notification),
      child: child,
    );
  }
}
