import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/icons.dart';
import 'package:ox_sdk/src/odesign/themings/theme.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/odesign/tooltip.dart';
import 'package:ox_sdk/src/utils/components/adaptative_layout_builder.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';




class OFormField extends StatelessWidget {
  const OFormField({ 
    Key? key,
    this.label,
    required this.child,
    this.fieldSize,
    this.errors,
    this.layout
  }) : super(key: key);

  final Widget? label;
  final double? fieldSize;
  final Widget child;
  final List<Widget>? errors;
  final LayoutDensity? layout;

  @override
  Widget build(BuildContext context) {
    Widget? effectiveLabel;
    if (label != null) {
      effectiveLabel = DefaultTextStyle.merge(
        style: Theme.of(context).inputDecorationTheme.labelStyle,
        child: label!
      );
    }

    Widget effectiveField = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: fieldSize != null 
                ? fieldSize! - (errors != null && errors?.isNotEmpty == true ? 22 : 0) 
                : double.infinity
            ),
            child: child
          )
        ),
        if (errors != null && errors?.isNotEmpty == true)
          OTooltip(
            tooltip: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: errors!
            ),
            child: Icon(
              IconsRes.error, 
              color: Theme.of(context).colors.error,
              size: 22,
            )
          )
      ],
    );
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
          titleMedium: Theme.of(context).textTheme.bodyMedium
        )
      ),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: Theme.of(context).radiuses.small,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Theme.of(context).paddings.medium
          ),
          child: AdaptativeLayoutBuilder(
            forceDensity: layout,
            narrow: Padding(
              padding: EdgeInsets.only(
                top: effectiveLabel == null ? 0 : Theme.of(context).paddings.medium
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (effectiveLabel != null)
                    effectiveLabel, 
                  effectiveField
                ],
              ),
            ),
            wide: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (effectiveLabel != null)
                  effectiveLabel, 
                const PaddingSpacer(),
                effectiveField
              ]
            ),
          ),
        ),
      ),
    );
  }
}



