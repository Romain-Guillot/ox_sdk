import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/icons.dart';
import 'package:ox_sdk/src/odesign/themings/theme.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/odesign/tooltip.dart';
import 'package:ox_sdk/src/utils/components/adaptative_layout_builder.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';
import 'package:ox_sdk/src/xframework/form/validators.dart';

typedef OFormFieldErrorBuilder = Widget Function(XValidatorError error);

class InheritedOFormFieldErrorBuilder extends InheritedWidget {
  const InheritedOFormFieldErrorBuilder({
    super.key,
    required this.builder,
    required super.child,
  });

  final OFormFieldErrorBuilder builder;

  static InheritedOFormFieldErrorBuilder? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedOFormFieldErrorBuilder>();
  }

  static InheritedOFormFieldErrorBuilder of(BuildContext context) {
    final InheritedOFormFieldErrorBuilder? result = maybeOf(context);
    assert(result != null, 'No FrogColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(InheritedOFormFieldErrorBuilder oldWidget) => builder != oldWidget.builder;
}

class OFormField extends StatelessWidget {
  const OFormField({
    Key? key,
    this.label,
    this.labelStyle,
    required this.child,
    this.fieldSize,
    this.errors,
    this.layout,
    this.expandField = false,
    this.leading,
  }) : super(key: key);

  final Widget? label;
  final TextStyle? labelStyle;
  final double? fieldSize;
  final Widget child;
  final List<XValidatorError>? errors;
  final LayoutDensity? layout;
  final bool expandField;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final errorBuilder = InheritedOFormFieldErrorBuilder.of(context).builder;

    Widget? effectiveLabel;
    if (label != null) {
      effectiveLabel = DefaultTextStyle.merge(
        style: labelStyle ?? Theme.of(context).inputDecorationTheme.labelStyle,
        child: label!,
      );
    }

    Widget effectiveField = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: fieldSize != null ? fieldSize! - (errors != null && errors?.isNotEmpty == true ? 22 : 0) : double.infinity,
            ),
            child: child,
          ),
        ),
        if (leading != null) leading!,
        if (errors != null && errors?.isNotEmpty == true)
          OTooltip(
            tooltip: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: errors?.map((e) => errorBuilder(e)).toList() ?? [],
            ),
            child: Icon(
              IconsRes.error,
              color: Theme.of(context).colors.error,
              size: 22,
            ),
          )
      ],
    );
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(titleMedium: Theme.of(context).textTheme.bodyMedium),
      ),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Theme.of(context).radiuses.small,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: expandField ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: Theme.of(context).paddings.medium),
          child: AdaptativeLayoutBuilder(
            forceDensity: layout,
            narrow: Padding(
              padding: EdgeInsets.only(
                top: effectiveLabel == null ? 0 : Theme.of(context).paddings.medium,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (effectiveLabel != null) effectiveLabel,
                  effectiveField,
                ],
              ),
            ),
            wide: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (effectiveLabel != null) ...[
                  effectiveLabel,
                  const PaddingSpacer(),
                ],
                Expanded(
                  child: effectiveField,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
