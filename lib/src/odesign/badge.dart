import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';


enum OBadgeShape {
  circle,
  square
}


class OBadge extends StatelessWidget {
  const OBadge({ 
    Key? key,
    this.color,
    this.label,
    this.onTap,
    this.shape = OBadgeShape.circle
  }) : super(key: key);

  final Color? color;
  final Widget? label;
  final VoidCallback? onTap;
  final OBadgeShape shape;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: ThemeExtension.of(context).smallBorderRadius,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ThemeExtension.of(context).paddingSmall
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (color != null)
              Container(
                constraints: BoxConstraints(
                  maxHeight: label == null ? 20 : 12,
                  maxWidth: label == null ? 20 : 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: shape == OBadgeShape.circle
                    ? BorderRadius.circular(9999)
                    : ThemeExtension.of(context).tinyBorderRadius,
                  color: color,
                ),
                child: const SizedBox.expand(),
              ),
            if (color != null && label != null)
              PaddingSpacer.small(),
            if (label != null)
              DefaultTextStyle.merge(
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: color
                ), 
                child: label!
              )
          ],
        ),
      ),
    );
  }
}