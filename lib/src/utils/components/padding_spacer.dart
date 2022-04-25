import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';



enum PaddingType {
  normal,
  small,
  big,
}



class PaddingSpacer extends StatelessWidget {
  const PaddingSpacer({
    Key? key, 
    this.type = PaddingType.normal
  }) : super(key: key);

  final PaddingType type;

  factory PaddingSpacer.small() => const PaddingSpacer(type: PaddingType.small);
  factory PaddingSpacer.big() => const PaddingSpacer(type: PaddingType.big);

  double getPaddingValue(BuildContext context) {
    switch (type) {
      case PaddingType.normal: return ThemeExtension.of(context).padding;
      case PaddingType.small: return ThemeExtension.of(context).paddingSmall;
      case PaddingType.big: return ThemeExtension.of(context).paddingBig;
 
    }
  }

  @override
  Widget build(BuildContext context) {
    final double padding = getPaddingValue(context);
    return SizedBox(
      height: padding,
      width: padding,
    );
  }
}