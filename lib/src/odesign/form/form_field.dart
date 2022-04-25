import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/icons.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/odesign/tooltip.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';


class OFormField extends StatelessWidget {
  const OFormField({ 
    Key? key,
    required this.label,
    required this.child,
    this.fieldSize,
    this.errors
  }) : super(key: key);

  final Widget label;
  final double? fieldSize;
  final Widget child;
  final List<Widget>? errors;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(context).textTheme.copyWith(
          titleMedium: Theme.of(context).textTheme.bodyMedium
        )
      ),
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: ThemeExtension.of(context).smallBorderRadius,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ThemeExtension.of(context).padding
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTextStyle.merge(
                style: Theme.of(context).inputDecorationTheme.labelStyle,
                child: label
              ),
              const PaddingSpacer(),
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
                    color: ThemeExtension.of(context).errorColor,
                    size: 22,
                  )
                )
            ],
          ),
        ),
      ),
    );
  }
}



