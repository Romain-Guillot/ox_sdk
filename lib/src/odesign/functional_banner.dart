import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';

enum FunctionalLevel {
  info,
  warning,
  error,
  success,
}

extension on FunctionalLevel {
  Color color(BuildContext context) {
    final theme = Theme.of(context);
    switch (this) {
      case FunctionalLevel.info:
        return theme.colors.info;

      case FunctionalLevel.warning:
        return theme.colors.warning;

      case FunctionalLevel.error:
        return theme.colors.error;

      case FunctionalLevel.success:
        return theme.colors.success;
    }
  }

  Widget icon(BuildContext context) {
    switch (this) {
      case FunctionalLevel.info:
        return const Icon(Icons.info_outline);

      case FunctionalLevel.warning:
        return const Icon(Icons.warning_amber_rounded);

      case FunctionalLevel.error:
        return const Icon(Icons.error_outline);

      case FunctionalLevel.success:
        return const Icon(Icons.check_circle_outline_rounded);
    }
  }
}

class FunctionalBanner extends StatelessWidget {
  const FunctionalBanner({
    super.key,
    required this.level,
    required this.child,
    this.onTap,
  });

  final FunctionalLevel level;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      type: MaterialType.transparency,
      borderRadius: theme.radiuses.small,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: theme.paddings.tiny),
          child: Row(
            children: [
              IconTheme.merge(
                data: IconThemeData(
                  size: 16,
                  color: level.color(context),
                ),
                child: level.icon(context),
              ),
              PaddingSpacer.small(),
              IconTheme.merge(
                data: IconThemeData(color: level.color(context)),
                child: DefaultTextStyle.merge(
                  style: TextStyle(color: level.color(context)),
                  child: Expanded(child: child),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
