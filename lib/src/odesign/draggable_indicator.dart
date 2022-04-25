import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';


class DraggableIndicator extends StatelessWidget {
  const DraggableIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ThemeExtension.of(context).paddingSmall),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}