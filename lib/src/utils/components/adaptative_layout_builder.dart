import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';



class AdaptativeLayoutBuilder extends StatelessWidget {
  const AdaptativeLayoutBuilder({ 
    Key? key,
    this.availableWidth,
    this.breakpoint,
    required this.narrow,
    required this.wide
  }) : super(key: key);

  final double? availableWidth;
  final double? breakpoint;
  final Widget wide;
  final Widget narrow;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveMaxWidth = availableWidth ?? constraints.maxWidth;
        final effectiveBreakpoint = breakpoint ?? ThemeExtension.of(context).mobileScreenMax;
        return effectiveMaxWidth > effectiveBreakpoint
          ? wide 
          : narrow;
      },
    );
  }
}