import 'package:flutter/material.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';


enum OTitleType {
  card, dialog
}


class OTitle extends StatelessWidget {
  const OTitle({ 
    Key? key,
    this.icon,
    required this.label,
    this.type = OTitleType.card
  }) : super(key: key);

  final Widget? icon;
  final Widget label;
  final OTitleType type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null)...[
          IconTheme(
            data: const IconThemeData(size: 28),
            child: icon!
          ),
          const PaddingSpacer(),
        ],
        DefaultTextStyle.merge(
          style: type == OTitleType.card
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.headlineSmall,
          child: label
        ),
      ],
    );
  }
}