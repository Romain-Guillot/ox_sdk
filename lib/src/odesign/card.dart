import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';


enum OCardType {
  main,
  component
}


enum OCardFunction {
  classic,
  error,
  info
}



extension on OCardFunction {
  Color backgroundColor(BuildContext context) {
    switch (this) {
      case OCardFunction.classic:
        return Theme.of(context).colorScheme.surface;
      case OCardFunction.error:
        return ThemeExtension.of(context).errorColor;
      case OCardFunction.info:
        return ThemeExtension.of(context).infoColor;
    }
  }

  Color foregroundColor(BuildContext context) {
    switch (this) {
      case OCardFunction.classic:
        return Theme.of(context).colorScheme.onSurface;
      case OCardFunction.error:
        return ThemeExtension.of(context).onErrorColor;
      case OCardFunction.info:
        return ThemeExtension.of(context).onInfoColor;
    }
  }
}



class OCard extends StatelessWidget {
  const OCard({ 
    Key? key,
    this.title,
    this.type = OCardType.component,
    this.actions,
    required this.child,
    this.elevation,
    this.function = OCardFunction.classic,
    this.mainAxisSize = MainAxisSize.min,
    this.hasContentPadding = false,
    this.onTap,
    this.expand = false
  }) : super(key: key);

  final Widget? title;
  final OCardType type;
  final List<Widget>? actions;
  final Widget child;
  final double? elevation;
  final OCardFunction function;
  final MainAxisSize mainAxisSize;
  final bool hasContentPadding;
  final VoidCallback? onTap;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final padding = ThemeExtension.of(context).mediumComponentPadding;
    final radius = type == OCardType.component
      ? ThemeExtension.of(context).mediumBorderRadius
      : BorderRadius.only(
        topLeft: ThemeExtension.of(context).mediumBorderRadius.topLeft,
        topRight: ThemeExtension.of(context).mediumBorderRadius.topRight
      ) ;
    Widget _child = child;
    if (expand) {
      _child = Expanded(
        child: _child,
      );
    }
    if (hasContentPadding) {
      _child = Padding(
        padding: hasContentPadding
          ? EdgeInsets.all(padding).copyWith(top: title == null ? null : 0)
          : EdgeInsets.zero,
        child: _child,
      );
    }

    return Material(
      color: function.backgroundColor(context),
      elevation: elevation ?? 0,
      borderRadius: radius,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: mainAxisSize == MainAxisSize.min ? null : double.maxFinite,
          child: DefaultTextStyle.merge(
            style: TextStyle(color: function.foregroundColor(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null || actions != null)
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: Row(
                      children: [
                        Expanded(
                          child: title != null 
                            ? DefaultTextStyle.merge(
                                style: Theme.of(context).textTheme.titleMedium,
                                child: title!
                              ) 
                            : Container()
                        ),
                        if (actions != null)
                          ...actions!.map((action) {
                            final isLastAction = actions!.last == action;
                            return Padding(
                              padding: EdgeInsets.only(
                                right: !isLastAction ? ThemeExtension.of(context).paddingSmall : 0
                              ),
                              child: action,
                            );
                          })
                      ],
                    ),
                  ),
                _child
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}