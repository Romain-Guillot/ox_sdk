import 'package:flutter/material.dart';

enum OTitleType { card, dialog }

enum OTitleStyle {
  small,
  normal,
}

class OTitle extends StatelessWidget {
  const OTitle({
    Key? key,
    this.icon,
    required this.label,
    this.type = OTitleType.card,
    this.style = OTitleStyle.normal,
  }) : super(key: key);

  final Widget? icon;
  final Widget label;
  final OTitleType type;
  final OTitleStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          SizedBox(
            width: 40,
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconTheme.merge(
                data: IconThemeData(size: style.iconSize(context)),
                child: icon!,
              ),
            ),
          ),
        Expanded(
          child: DefaultTextStyle.merge(
            style: type == OTitleType.card ? style.titleStyle(context) : Theme.of(context).textTheme.headlineSmall,
            child: label,
          ),
        )
      ],
    );
  }
}

extension on OTitleStyle {
  double iconSize(BuildContext context) {
    switch (this) {
      case OTitleStyle.normal:
        return 24;
      case OTitleStyle.small:
        return 18;
    }
  }

  TextStyle? titleStyle(BuildContext context) {
    switch (this) {
      case OTitleStyle.normal:
        return Theme.of(context).textTheme.titleMedium;
      case OTitleStyle.small:
        return Theme.of(context).textTheme.titleSmall;
    }
  }
}
