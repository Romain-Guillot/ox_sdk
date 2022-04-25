import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';


enum OTooltipBehavior {
  onHover,
  onTap
}


class OTooltip extends StatefulWidget {
  const OTooltip({ 
    Key? key,
    this.tooltip,
    this.behavior = OTooltipBehavior.onHover,
    required this.child
  }) : super(key: key);


  final Widget? tooltip;
  final OTooltipBehavior behavior;
  final Widget child;

  @override
  State<OTooltip> createState() => _OTooltipState();
}

class _OTooltipState extends State<OTooltip> {
  final _tooltipController = JustTheController();

  @override
  Widget build(BuildContext context) {
    final theme = ThemeExtension.of(context).tooltipTheme;
    return JustTheTooltip(
      backgroundColor: theme?.backgroundColor,
      content: Padding(
        padding: theme?.padding ?? EdgeInsets.all(ThemeExtension.of(context).padding),
        child: DefaultTextStyle.merge(
          style: theme?.style,
          child: widget.tooltip ?? Container()
        ),
      ),
      controller: _tooltipController,
      child: InkWell(
        onHover: (isHover) {
          if (widget.tooltip == null) {
            return ;
          }
          if (isHover) {
            _tooltipController.showTooltip(immediately: true);
          } {
            _tooltipController.hideTooltip(immediately: true);
          }
        },
        child: widget.child
      )
    );
  }
}