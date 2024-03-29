import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';

enum PaddingType { normal, small, big, tiny }

class PaddingSpacer extends StatelessWidget {
  const PaddingSpacer({Key? key, this.type = PaddingType.normal}) : super(key: key);

  final PaddingType type;

  const PaddingSpacer.tiny() : type = PaddingType.tiny;
  const PaddingSpacer.small() : type = PaddingType.small;
  const PaddingSpacer.big() : type = PaddingType.big;

  double getPaddingValue(BuildContext context) {
    final paddings = Theme.of(context).paddings;
    switch (type) {
      case PaddingType.normal:
        return paddings.medium;
      case PaddingType.small:
        return paddings.small;
      case PaddingType.big:
        return paddings.big;
      case PaddingType.tiny:
        return paddings.tiny;
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
