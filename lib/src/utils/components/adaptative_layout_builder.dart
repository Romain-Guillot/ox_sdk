import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';



class AdaptativeLayoutBuilder extends StatelessWidget {
  const AdaptativeLayoutBuilder({ 
    Key? key,
    this.availableWidth,
    this.breakpoint,
    required this.narrow,
    required this.wide,
    this.forceDensity
  }) : super(key: key);

  final double? availableWidth;
  final double? breakpoint;
  final Widget wide;
  final Widget narrow;
  final LayoutDensity? forceDensity;

  @override
  Widget build(BuildContext context) {
    switch (forceDensity) {
      case LayoutDensity.wide:
        return wide;
      case LayoutDensity.narrow:
        return narrow;
      default:
      return LayoutBuilder(
        builder: (context, constraints) {
          final effectiveMaxWidth = availableWidth ?? constraints.maxWidth;
          final effectiveBreakpoint = breakpoint ?? Theme.of(context).constraints.mobileScreenMax;
          return effectiveMaxWidth > effectiveBreakpoint
            ? wide 
            : narrow;
        },
      );
    }

  }
}