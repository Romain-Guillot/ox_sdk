import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart' hide TextDirection;
import 'package:ox_sdk/src/odesign/drawer.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';

enum OButtonStyle {
  primary,
  secondary,
}

enum OButtonLayout { row, column }

enum OButtonIconPlacement { iconToRight, iconToLeft }

class OButtonPopupEntry<T> {
  const OButtonPopupEntry({this.icon, required this.value, required this.label, this.color});

  final T value;
  final Widget? icon;
  final Widget label;
  final Color? color;
}

class OPopupMenu {
  static Future<T?> show<T>({required BuildContext context, required List<OButtonPopupEntry<T>> entries, required RelativeRect position}) async {
    final popupMenuTheme = PopupMenuTheme.of(context);
    final items = entries
        .map((entry) => PopupMenuItem<T>(
              value: entry.value,
              textStyle: (Theme.of(context).textTheme.labelLarge ?? const TextStyle()).copyWith(color: entry.color),
              child: Row(children: [
                if (entry.icon != null) ...[
                  IconTheme(data: IconThemeData(size: 18, color: entry.color), child: entry.icon!),
                  PaddingSpacer.small(),
                ],
                entry.label
              ]),
            ))
        .toList();
    if (items.isNotEmpty) {
      return showMenu<T?>(
          context: context,
          elevation: popupMenuTheme.elevation,
          items: items,
          position: position,
          shape: RoundedRectangleBorder(borderRadius: Theme.of(context).radiuses.small));
    }
    return null;
  }
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
    this.heroTag,
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
  final Object? heroTag;

  @override
  State<OButton<T>> createState() => _OButtonState<T>();
}

class _OButtonState<T> extends State<OButton<T>> {
  void showButtonMenu() {
    final button = context.findRenderObject()! as RenderBox;
    final overlay = Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset(0, button.size.height), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero) + Offset.zero, ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    OPopupMenu.show<T?>(
      context: context,
      entries: widget.popupMenuEntries ?? [],
      position: position,
    ).then<void>((T? newValue) {
      if (newValue != null) {
        widget.onSelected?.call(newValue);
      }
    });
  }

  VoidCallback? get effectiveOnPressed {
    return widget.popupMenuEntries != null ? showButtonMenu : widget.onTap;
  }

  Widget _buildFAB(BuildContext context) {
    Widget? effectiveLabel = widget.label;
    final drawerState = ODrawer.maybeOf(context);
    FloatingActionButtonThemeData fabTheme = Theme.of(context).floatingActionButtonTheme;
    switch (widget.style) {
      case OButtonStyle.primary:
        fabTheme = fabTheme.copyWith(
            foregroundColor: widget.buttonStyle?.foregroundColor?.resolve({}),
            backgroundColor: effectiveOnPressed == null
                ? ColorOperations.lighten(widget.buttonStyle?.backgroundColor?.resolve({}) ?? fabTheme.backgroundColor!, 0.5)
                : widget.buttonStyle?.backgroundColor?.resolve({}) ?? fabTheme.backgroundColor);
        break;
      case OButtonStyle.secondary:
        fabTheme = fabTheme.copyWith(
            backgroundColor: Colors.transparent,
            foregroundColor: effectiveOnPressed == null
                ? ColorOperations.lighten(widget.buttonStyle?.foregroundColor?.resolve({}) ?? Theme.of(context).colorScheme.onBackground, 0.5)
                : widget.buttonStyle?.foregroundColor?.resolve({}) ?? Theme.of(context).colorScheme.onBackground);
        break;
    }
    return Theme(
        data: Theme.of(context).copyWith(floatingActionButtonTheme: fabTheme),
        child: SizedBox(
          width: widget.mainSize == MainAxisSize.max ? double.maxFinite : null,
          child: effectiveLabel != null && widget.icon != null
              ? FloatingActionButton.extended(
                  heroTag: widget.heroTag,
                  onPressed: effectiveOnPressed,
                  label: effectiveLabel,
                  icon: widget.icon!,
                  isExtended: drawerState == null || drawerState.opened == true,
                )
              : FloatingActionButton(
                  heroTag: widget.heroTag,
                  onPressed: effectiveOnPressed,
                  child: effectiveLabel ?? widget.icon,
                ),
        ));
  }

  ButtonStyle? _buttonStyle(BuildContext context) {
    ButtonStyle? style = widget.buttonStyle ?? Theme.of(context).textButtonTheme.style;
    switch (widget.style) {
      case OButtonStyle.primary:
        return style;
      case OButtonStyle.secondary:
        return TextButton.styleFrom(backgroundColor: Colors.transparent, primary: style?.backgroundColor?.resolve({})).merge(style);
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
              children: [icon, label],
            ),
          );
        case OButtonLayout.row:
          return TextButton.icon(style: _buttonStyle(context), onPressed: effectiveOnPressed, icon: icon, label: label);
      }
    } else if (label != null) {
      return TextButton(style: _buttonStyle(context), onPressed: effectiveOnPressed, child: label);
    } else {
      return TextButton(style: _buttonStyle(context), onPressed: effectiveOnPressed, child: icon!);
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
      child = Directionality(textDirection: TextDirection.rtl, child: child);
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

class OFilledButton extends StatelessWidget {
  const OFilledButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    this.loading = false,
    this.enabled = true,
    this.icon,
    required this.label,
  });

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final MaterialStatesController? statesController;
  final bool loading;
  final bool enabled;
  final Widget? icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    Widget? effectiveIcon = loading ? const OLoader(size: OLoaderSize.small) : icon;
    if (effectiveIcon == null) {
      return FilledButton(
        onPressed: enabled && onPressed != null ? () => onPressed?.call() : null,
        onLongPress: enabled && onPressed != null ? () => onLongPress?.call() : null,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        statesController: statesController,
        child: label,
      );
    } else {
      return FilledButton.icon(
        onPressed: enabled && onPressed != null ? () => onPressed?.call() : null,
        onLongPress: enabled && onPressed != null ? () => onLongPress?.call() : null,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        statesController: statesController,
        icon: effectiveIcon,
        label: label,
      );
    }
  }
}

class OTextButton extends StatelessWidget {
  const OTextButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    this.loading = false,
    this.enabled = true,
    this.icon,
    required this.label,
  });

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final MaterialStatesController? statesController;
  final bool loading;
  final bool enabled;
  final Widget? icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    Widget? effectiveIcon = loading ? const OLoader(size: OLoaderSize.small) : icon;
    if (effectiveIcon == null) {
      return TextButton(
        onPressed: enabled && onPressed != null ? () => onPressed?.call() : null,
        onLongPress: enabled && onPressed != null ? () => onLongPress?.call() : null,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        statesController: statesController,
        child: label,
      );
    } else {
      return TextButton.icon(
        onPressed: enabled && onPressed != null ? () => onPressed?.call() : null,
        onLongPress: enabled && onPressed != null ? () => onLongPress?.call() : null,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        statesController: statesController,
        icon: effectiveIcon,
        label: label,
      );
    }
  }
}

class OOutlinedButton extends StatelessWidget {
  const OOutlinedButton({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    this.loading = false,
    this.enabled = true,
    this.icon,
    required this.label,
  });

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final MaterialStatesController? statesController;
  final bool loading;
  final bool enabled;
  final Widget? icon;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    Widget? effectiveIcon = loading ? const OLoader(size: OLoaderSize.small) : icon;
    if (effectiveIcon == null) {
      return OutlinedButton(
        onPressed: enabled && onPressed != null ? () => onPressed?.call() : null,
        onLongPress: enabled && onPressed != null ? () => onLongPress?.call() : null,
        onHover: onHover,
        onFocusChange: onFocusChange,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        statesController: statesController,
        child: label,
      );
    } else {
      return OutlinedButton.icon(
        onPressed: enabled && onPressed != null ? () => onPressed?.call() : null,
        onLongPress: enabled && onPressed != null ? () => onLongPress?.call() : null,
        style: style,
        focusNode: focusNode,
        autofocus: autofocus,
        clipBehavior: clipBehavior,
        statesController: statesController,
        icon: effectiveIcon,
        label: label,
      );
    }
  }
}
