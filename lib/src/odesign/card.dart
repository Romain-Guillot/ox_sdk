import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/supporting_colors.dart';
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


enum OCardDensity {
  small,
  medium,
  large
}


enum OCardStyle {
  normal,
  highlight
}

extension on OCardFunction {
  Color backgroundColor(BuildContext context) {
    switch (this) {
      case OCardFunction.classic:
        return Theme.of(context).colorScheme.surface;
      case OCardFunction.error:
        return Theme.of(context).colors.error;
      case OCardFunction.info:
        return Theme.of(context).colors.info;
    }
  }

  Color foregroundColor(BuildContext context) {
    switch (this) {
      case OCardFunction.classic:
        return Theme.of(context).colorScheme.onSurface;
      case OCardFunction.error:
        return Theme.of(context).colors.onError;
      case OCardFunction.info:
        return Theme.of(context).colors.onInfo;
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
    this.expand = false,
    this.supporting,
    this.centerTitle = false,
    this.density = OCardDensity.medium,
    this.supportingStyle = OCardStyle.normal
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
  final SupportingColors? supporting;
  final OCardStyle supportingStyle;
  final bool centerTitle;
  final OCardDensity density;

  @override
  Widget build(BuildContext context) {
    double padding;
    switch (density) {
      case OCardDensity.small:
        padding = Theme.of(context).paddings.small;
        break;
      case OCardDensity.medium:
        padding = Theme.of(context).paddings.medium;
        break;
      case OCardDensity.large:
      padding = Theme.of(context).paddings.big;
        break;
    }
    final radius = type == OCardType.component
      ? Theme.of(context).radiuses.medium
      : BorderRadius.only(
        topLeft: Theme.of(context).radiuses.medium.topLeft,
        topRight: Theme.of(context).radiuses.medium.topRight
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

    final supportingColors = Theme.of(context).colors.supportings[supporting];
    Color cardColor;
    Color foregroundColor;
    ButtonStyle? buttonStyle;
    if (supportingColors != null) {
      switch (supportingStyle) {
        case OCardStyle.highlight:
          cardColor = supportingColors.primary;
          foregroundColor = supportingColors.onPrimary;
          buttonStyle = TextButton.styleFrom(
            primary: supportingColors.onVariant,
            backgroundColor: supportingColors.variant
          ).merge(Theme.of(context).textButtonTheme.style);
          break;
        case OCardStyle.normal:
          cardColor = supportingColors.container;
          foregroundColor = supportingColors.onContainer;
          buttonStyle = TextButton.styleFrom(
            primary: supportingColors.onPrimary,
            backgroundColor: supportingColors.primary
          ).merge(Theme.of(context).textButtonTheme.style);
          break;
      }
    } else {
      cardColor = function.backgroundColor(context);
      foregroundColor = function.foregroundColor(context);
      buttonStyle = Theme.of(context).textButtonTheme.style;
    }
    return Material(
      color: cardColor,
      elevation: elevation ?? 0,
      borderRadius: radius,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: foregroundColor,
            displayColor: foregroundColor
          ),
          textButtonTheme: TextButtonThemeData(
          style: buttonStyle
          ),
        ),
        child: Builder(
          builder: (context) => InkWell(
            onTap: onTap,
            child: SizedBox(
              width: mainAxisSize == MainAxisSize.min ? null : double.maxFinite,
              child: DefaultTextStyle.merge(
                style: TextStyle(color: foregroundColor),
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
                                    textAlign: centerTitle ? TextAlign.center : TextAlign.left,
                                    child: Align(
                                      alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
                                      child: title!
                                    )
                                  ) 
                                : Container()
                            ),
                            if (actions != null)
                              ...actions!.map((action) {
                                final isLastAction = actions!.last == action;
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: !isLastAction 
                                      ? (Theme.of(context).paddings.small)
                                      : 0
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
        ),
      ),
    );
  }
}