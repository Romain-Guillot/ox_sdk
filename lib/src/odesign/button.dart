import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/drawer.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';


enum OButtonStyle {
  primary,
  secondary,
  floating,
  floatingSecondary,
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


enum OButtonIconPlacement {
  iconToRight,
  iconToLeft
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
    this.mainSize = MainAxisSize.min,
    this.brightness,
    this.color,
    this.iconPlacement = OButtonIconPlacement.iconToLeft
  }) : super(key: key);

  final Widget? label;
  final Icon? icon;
  final OButtonStyle style;
  final VoidCallback? onTap;
  final PopupMenuItemSelected<T>? onSelected;
  final MainAxisSize mainSize;
  final List<OButtonPopupEntry<T>>? popupMenuEntries;
  final Brightness? brightness;
  final Color? color;
  final OButtonIconPlacement iconPlacement;

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
      value: entry.value,
      textStyle: (Theme.of(context).textTheme.labelLarge ?? const TextStyle()).copyWith(
        color: entry.color
      ),
    )).toList();
    // Only show the menu if there is something to show
    if (items.isNotEmpty) {
      showMenu<T?>(
        context: context,
        elevation: popupMenuTheme.elevation,
        items: items,
        position: position,
        shape: RoundedRectangleBorder(
          borderRadius: ThemeExtension.of(context).smallBorderRadius
        )
      )
      .then<void>((T? newValue) {
        if (newValue != null) {
          widget.onSelected?.call(newValue);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBrightness = widget.brightness ?? Theme.of(context).brightness;
    final isLight = effectiveBrightness == Brightness.light;
    final backColor = widget.style != OButtonStyle.secondary && widget.style != OButtonStyle.floatingSecondary;
    final colors = Theme.of(context).colorScheme;

    final backColorValue = backColor 
          ? (widget.color ?? (isLight ? colors.secondary : colors.onSecondary))
          : Colors.transparent;
    final frontColorValue = backColor 
          ? (isLight ? colors.onSecondary : colors.secondary)
          : (widget.color ?? (isLight ? colors.onBackground : colors.background));
    Widget? effectiveLabel = widget.label;
    final isFloating = widget.style == OButtonStyle.floating || widget.style == OButtonStyle.floatingSecondary;
    if (isFloating) {
      final drawerState = ODrawer.maybeOf(context);
      if (drawerState?.opened == false) {
        effectiveLabel = null;
      }
    }

    var children = [
      if (widget.icon != null)
        widget.icon!,
      if (widget.icon != null && effectiveLabel != null)
        isFloating ? const PaddingSpacer() : PaddingSpacer.small(),
      if (effectiveLabel != null)
        Flexible(
          child: Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: effectiveLabel,
          ),
        )
    ];
    if (widget.iconPlacement == OButtonIconPlacement.iconToRight) {
      children = children.reversed.toList();
    }
    final disabled = widget.onTap == null && widget.onSelected == null;
    return Opacity(
      opacity: disabled ? 0.55 : 1,
      child: Material(
        color: backColorValue,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: ThemeExtension.of(context).smallBorderRadius,
        child: DefaultTextStyle.merge(
          maxLines: 1,
          softWrap: false,
          style: (Theme.of(context).textTheme.labelLarge ?? const TextStyle()).copyWith(
            color: frontColorValue
          ),
          child: IconTheme.merge(
            data: IconThemeData(
              color: frontColorValue
            ),
            child: InkWell(
              onTap: widget.popupMenuEntries != null
                ? showButtonMenu
                : widget.onTap,
              child: Container(
                padding: isFloating 
                  ? EdgeInsets.all(ThemeExtension.of(context).smallComponentPadding)
                  : const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: widget.icon != null && widget.label != null 
                    ? MainAxisAlignment.start 
                    : MainAxisAlignment.center,
                  mainAxisSize: widget.mainSize,
                  children: children,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}