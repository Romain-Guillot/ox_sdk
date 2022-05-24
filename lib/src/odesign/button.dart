import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';
import 'package:ox_sdk/src/odesign/drawer.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';



enum OButtonStyle {
  primary,
  secondary,
}


enum OButtonLayout {
  row,
  column
}


enum OButtonIconPlacement {
  iconToRight,
  iconToLeft
}


class OButtonPopupEntry<T> {
  const OButtonPopupEntry({
    this.icon,
    required this.value,
    required this.label,
    this.color
  });

  final T value;
  final Widget? icon;
  final Widget label;
  final Color? color;
}





class OButton<T> extends StatefulWidget {
  const OButton({ 
    Key? key,
    this.label,
    this.icon,
    this.onTap,
    this.onSelected,
    this.popupMenuEntries,
    this.style = OButtonStyle.primary,
    this.layout = OButtonLayout.row,
    this.iconPlacement = OButtonIconPlacement.iconToLeft,
    this.mainSize = MainAxisSize.min,
    this.isFloating = false,
    this.buttonStyle,
  }) : super(key: key);

  final Widget? label;
  final Widget? icon;
  final OButtonStyle style;
  final VoidCallback? onTap;
  final PopupMenuItemSelected<T>? onSelected;
  final MainAxisSize mainSize;
  final List<OButtonPopupEntry<T>>? popupMenuEntries;
  final OButtonIconPlacement iconPlacement;
  final OButtonLayout layout;
  final bool isFloating;
  final ButtonStyle? buttonStyle;

  @override
  State<OButton<T>> createState() => _OButtonState<T>();
}

class _OButtonState<T> extends State<OButton<T>> {
  void showButtonMenu() {
    final popupMenuTheme = PopupMenuTheme.of(context);
    final button = context.findRenderObject()! as RenderBox;
    final overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, button.size.height), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + Offset.zero, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    final items = widget.popupMenuEntries!.map((entry) => PopupMenuItem<T>(
      value: entry.value,
      textStyle: (Theme.of(context).textTheme.labelLarge ?? const TextStyle()).copyWith(
        color: entry.color
      ),
      child: Row(children: [
        if (entry.icon != null)...[
          IconTheme(
            data: IconThemeData(size: 18, color: entry.color),
            child: entry.icon!
          ),
          PaddingSpacer.small(),
        ],
        entry.label
      ]),
    )).toList();
    // Only show the menu if there is something to show
    if (items.isNotEmpty) {
      showMenu<T?>(
        context: context,
        elevation: popupMenuTheme.elevation,
        items: items,
        position: position,
        shape: RoundedRectangleBorder(
          borderRadius: Theme.of(context).radiuses.small
        )
      )
      .then<void>((T? newValue) {
        if (newValue != null) {
          widget.onSelected?.call(newValue);
        }
      });
    }
  }


  VoidCallback? get effectiveOnPressed {
    return widget.popupMenuEntries != null
      ? showButtonMenu
      : widget.onTap;
  }

   

  Widget _buildFAB(BuildContext context) {
    Widget? effectiveLabel = widget.label;
    final drawerState = ODrawer.maybeOf(context);
    if (drawerState?.opened == false) {
      effectiveLabel = null;
    }
    FloatingActionButtonThemeData fabTheme = Theme.of(context).floatingActionButtonTheme;
     switch (widget.style) {
      case OButtonStyle.primary:
        fabTheme = fabTheme.copyWith(
          foregroundColor: widget.buttonStyle?.foregroundColor?.resolve({}),
          backgroundColor: effectiveOnPressed == null
            ? ColorOperations.lighten(widget.buttonStyle?.backgroundColor?.resolve({}) ?? fabTheme.backgroundColor!, 0.5)
            : widget.buttonStyle?.backgroundColor?.resolve({}) ?? fabTheme.backgroundColor
        );
        break ;
      case OButtonStyle.secondary:
        fabTheme = fabTheme.copyWith(
          backgroundColor: Colors.transparent,
          foregroundColor: effectiveOnPressed == null
            ? ColorOperations.lighten(widget.buttonStyle?.foregroundColor?.resolve({}) ?? Theme.of(context).colorScheme.onBackground, 0.5)
            : widget.buttonStyle?.foregroundColor?.resolve({}) ?? Theme.of(context).colorScheme.onBackground
        );
        break;
    }
    return Theme(
      data: Theme.of(context).copyWith(
        floatingActionButtonTheme: fabTheme
      ),
      child: effectiveLabel != null && widget.icon != null
        ? FloatingActionButton.extended(
            onPressed: effectiveOnPressed, 
            label: effectiveLabel,
            icon: widget.icon!,
          )
        : FloatingActionButton(
            onPressed: effectiveOnPressed,
            child: effectiveLabel ?? widget.icon,
          ),
    );
  }


  ButtonStyle? _buttonStyle(BuildContext context) {
    ButtonStyle? style = widget.buttonStyle ?? Theme.of(context).textButtonTheme.style;
    switch (widget.style) {
      case OButtonStyle.primary:
        return style;
      case OButtonStyle.secondary:
        return TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          primary: style?.backgroundColor?.resolve({})
        ).merge(style);
    }
  }


  Widget _buildButton(BuildContext context) {
    final icon = widget.icon;
    final label = widget.label;
    if (icon != null && label != null) {
      switch (widget.layout) {
        case OButtonLayout.column:
          return TextButton(
            style: _buttonStyle(context),
            onPressed: effectiveOnPressed,
            child: Column(
              children: [
                icon,
                label
              ],
            ),
          );
        case OButtonLayout.row:
          return TextButton.icon(
            style: _buttonStyle(context),
            onPressed: effectiveOnPressed, 
            icon: icon, 
            label: label
          );
      }

    } else if (label != null) {
      return TextButton(
        style: _buttonStyle(context),
        onPressed: effectiveOnPressed, 
        child: label
      );
    } else {
      return TextButton(
        style: _buttonStyle(context),
        onPressed: effectiveOnPressed, 
        child: icon!
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    Widget child;
    if (widget.isFloating) {
      child = _buildFAB(context);
    } else {
      child = _buildButton(context);
    }
    if (widget.iconPlacement == OButtonIconPlacement.iconToRight) {
      child = Directionality(
        textDirection: TextDirection.rtl,
        child: child
      );
    }
    return child;
    // final effectiveBrightness = widget.brightness ?? Theme.of(context).brightness;
    // final isLight = effectiveBrightness == Brightness.light;
    // final backColor = widget.style != OButtonStyle.secondary && widget.style != OButtonStyle.floatingSecondary;
    // final colors = Theme.of(context).colorScheme;

    // final backColorValue = backColor 
    //       ? (widget.color ?? (isLight ? colors.secondary : colors.onSecondary))
    //       : Colors.transparent;
    // final frontColorValue = backColor 
    //       ? (isLight ? colors.onSecondary : colors.secondary)
    //       : (widget.color ?? (isLight ? colors.onBackground : colors.background));


    // return Material(
    //   color: backColorValue,
    //   child: DefaultTextStyle.merge(
    //     softWrap: false,
    //     style: (Theme.of(context).textTheme.labelLarge ?? const TextStyle()).copyWith(
    //       color: frontColorValue
    //     ),
    //     child: IconTheme.merge(
    //       data: IconThemeData(
    //         color: frontColorValue
    //       ),
    //       child: InkWell(
    //         child:  Row(
    //           mainAxisAlignment: widget.icon != null && widget.label != null 
    //             ? MainAxisAlignment.start 
    //             : MainAxisAlignment.center,
    //           mainAxisSize: widget.mainSize,
    //           children: children,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

