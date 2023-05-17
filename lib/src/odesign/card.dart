import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/supporting_colors.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';

enum OCardType {
  main,
  component,
  expanded,
}

enum OCardFunction {
  surface,
  primary,
  secondary,
  tertiary,
  error,
}

enum OCardDensity { small, medium, large }

enum OCardStyle { normal, highlight }

extension on OCardFunction {
  Color backgroundColor(BuildContext context) {
    switch (this) {
      case OCardFunction.primary:
        return Theme.of(context).colorScheme.primaryContainer;
      case OCardFunction.secondary:
        return Theme.of(context).colorScheme.secondaryContainer;
      case OCardFunction.error:
        return Theme.of(context).colorScheme.errorContainer;
      case OCardFunction.tertiary:
        return Theme.of(context).colorScheme.tertiaryContainer;
      case OCardFunction.surface:
        return Theme.of(context).colorScheme.surface;
    }
  }

  Color foregroundColor(BuildContext context) {
    switch (this) {
      case OCardFunction.primary:
        return Theme.of(context).colorScheme.onPrimaryContainer;
      case OCardFunction.secondary:
        return Theme.of(context).colorScheme.onSecondaryContainer;
      case OCardFunction.error:
        return Theme.of(context).colorScheme.onErrorContainer;
      case OCardFunction.tertiary:
        return Theme.of(context).colorScheme.onTertiaryContainer;
      case OCardFunction.surface:
        return Theme.of(context).colorScheme.onSurface;
    }
  }
}

class OCard extends StatefulWidget {
  const OCard({
    Key? key,
    this.title,
    this.type = OCardType.component,
    this.actions,
    this.child,
    this.elevation,
    this.function = OCardFunction.primary,
    this.mainAxisSize = MainAxisSize.min,
    this.hasContentPadding = false,
    this.onTap,
    this.expand = false,
    this.supporting,
    this.centerTitle = false,
    this.density = OCardDensity.medium,
    this.supportingStyle = OCardStyle.normal,
    this.clip = Clip.antiAliasWithSaveLayer,
    this.contentPadding,
    this.onLongPress,
    this.fullWidth = false,
    this.expandable = false,
    this.collapsed = false,
  }) : super(key: key);

  final Widget? title;
  final OCardType type;
  final List<Widget>? actions;
  final Widget? child;
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
  final Clip clip;
  final EdgeInsets? contentPadding;
  final VoidCallback? onLongPress;
  final bool fullWidth;
  final bool expandable;
  final bool collapsed;

  @override
  State<OCard> createState() => _OCardState();
}

class _OCardState extends State<OCard> {
  late bool _collapsed = false;
  bool get collapsed => _collapsed;
  set collapsed(bool value) {
    setState(() {
      _collapsed = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _collapsed = widget.collapsed;
  }

  @override
  Widget build(BuildContext context) {
    double padding;
    switch (widget.density) {
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
    BorderRadius radius;
    switch (widget.type) {
      case OCardType.component:
        radius = Theme.of(context).radiuses.medium;
        break;
      case OCardType.main:
        radius = BorderRadius.only(topLeft: Theme.of(context).radiuses.medium.topLeft, topRight: Theme.of(context).radiuses.medium.topRight);
        break;
      case OCardType.expanded:
        radius = BorderRadius.zero;
        break;
    }

    Widget? child = widget.child;
    Widget effectiveChild;
    if (child == null) {
      effectiveChild = const SizedBox.shrink();
    } else {
      effectiveChild = child;
      if (widget.hasContentPadding) {
        effectiveChild = Padding(
          padding: widget.hasContentPadding
              ? (widget.contentPadding ?? EdgeInsets.all(padding)).copyWith(top: widget.title == null ? null : 0)
              : EdgeInsets.zero,
          child: effectiveChild,
        );
      }
    }

    if (widget.expand) {
      effectiveChild = Expanded(
        child: effectiveChild,
      );
    }

    final supportingColors = Theme.of(context).colors.supportings[widget.supporting];
    Color cardColor;
    Color foregroundColor;
    ButtonStyle? buttonStyle;
    if (supportingColors != null) {
      switch (widget.supportingStyle) {
        case OCardStyle.highlight:
          cardColor = supportingColors.primary;
          foregroundColor = supportingColors.onPrimary;
          buttonStyle = TextButton.styleFrom(foregroundColor: supportingColors.onVariant, backgroundColor: supportingColors.variant)
              .merge(Theme.of(context).textButtonTheme.style);
          break;
        case OCardStyle.normal:
          cardColor = supportingColors.container;
          foregroundColor = supportingColors.onContainer;
          buttonStyle = TextButton.styleFrom(foregroundColor: supportingColors.container, backgroundColor: supportingColors.onContainer)
              .merge(Theme.of(context).textButtonTheme.style);
          break;
      }
    } else {
      cardColor = widget.function.backgroundColor(context);
      foregroundColor = widget.function.foregroundColor(context);
      buttonStyle = Theme.of(context).textButtonTheme.style;
    }
    return Card(
      margin: EdgeInsets.zero,
      color: cardColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
      ),
      clipBehavior: widget.clip,
      child: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: foregroundColor, displayColor: foregroundColor),
          textButtonTheme: TextButtonThemeData(style: buttonStyle),
        ),
        child: Builder(
          builder: (context) => InkWell(
            onTap: widget.onTap,
            onLongPress: widget.onLongPress,
            child: SizedBox(
              width: widget.fullWidth ? double.maxFinite : null,
              child: IconTheme.merge(
                data: IconThemeData(color: foregroundColor),
                child: DefaultTextStyle.merge(
                  style: TextStyle(color: foregroundColor),
                  child: Column(
                    mainAxisSize: widget.mainAxisSize,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.title != null || widget.actions != null)
                        InkWell(
                          onTap: widget.expandable
                              ? () {
                                  collapsed = !collapsed;
                                }
                              : null,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: padding),
                            child: Row(
                              children: [
                                Expanded(
                                    child: widget.title != null
                                        ? Padding(
                                            padding: EdgeInsets.symmetric(vertical: padding),
                                            child: DefaultTextStyle.merge(
                                              style: Theme.of(context).textTheme.titleMedium,
                                              textAlign: widget.centerTitle ? TextAlign.center : TextAlign.left,
                                              child: Align(
                                                alignment: widget.centerTitle ? Alignment.center : Alignment.centerLeft,
                                                child: widget.title!,
                                              ),
                                            ),
                                          )
                                        : Container()),
                                if (widget.actions != null)
                                  ...widget.actions!.map((action) {
                                    final isLastAction = widget.actions!.last == action;
                                    return Padding(
                                      padding: EdgeInsets.only(right: !isLastAction ? (Theme.of(context).paddings.small) : 0),
                                      child: action,
                                    );
                                  }),
                                if (widget.expandable)
                                  Icon(
                                    collapsed ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      if (collapsed == false) effectiveChild,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
