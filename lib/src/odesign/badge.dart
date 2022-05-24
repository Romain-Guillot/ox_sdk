import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';


enum OBadgeShape {
  circle,
  square
}


enum OBadgeStyle {
  flat,
  filled,
}


class OBadge extends StatelessWidget {
  const OBadge({ 
    Key? key,
    this.color,
    this.variant,
    this.label,
    this.onTap,
    this.shape = OBadgeShape.circle,
    this.style = OBadgeStyle.flat,
    this.selected = false,
    this.padding,
    this.trailing,
    this.leading
  }) : super(key: key);

  final Color? color;
  final Color? variant;
  final Widget? label;
  final VoidCallback? onTap;
  final OBadgeShape shape;
  final OBadgeStyle style;
  final bool selected;
  final EdgeInsets? padding;
  final Widget? trailing;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? foregroundColor;
    Color? iconColor;
    EdgeInsetsGeometry? effectivePadding;
    switch (style) {
      case OBadgeStyle.filled:
        backgroundColor = selected ? color : variant;
        foregroundColor = selected ? variant : color;
        iconColor = foregroundColor;
        effectivePadding = padding ?? EdgeInsets.all(Theme.of(context).paddings.small);
        break;
      case OBadgeStyle.flat:
        backgroundColor = selected ? color : Colors.transparent;
        foregroundColor = selected ? variant : null;
        iconColor = selected ? variant : color;
        effectivePadding = padding ?? EdgeInsets.symmetric(
          vertical: Theme.of(context).paddings.small
        );
        break;
    }
    final radius = Theme.of(context).radiuses.small;
    return Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: radius,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: IconTheme(
        data: IconThemeData(
          color: foregroundColor,
          size: 18
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: effectivePadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leading != null)
                  leading!,
                if (leading == null && iconColor != null)
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: label == null ? 20 : 12,
                      maxWidth: label == null ? 20 : 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: shape == OBadgeShape.circle
                        ? BorderRadius.circular(9999)
                        : Theme.of(context).radiuses.tiny,
                      color: iconColor,
                    ),
                    child: const SizedBox.expand(),
                  ),
                if (iconColor != null && label != null)
                  PaddingSpacer.small(),
                if (label != null)
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: foregroundColor
                    ), 
                    child: label!
                  ),
                if (trailing != null)...[
                  PaddingSpacer.small(),
                  trailing!,
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}