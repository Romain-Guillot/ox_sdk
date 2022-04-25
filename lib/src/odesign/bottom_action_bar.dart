
import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';


class OBottomActionsBar extends StatelessWidget {
  const OBottomActionsBar({
    Key? key,
    this.left,
    this.right,
  }) : super(key: key);

  final Widget? left;
  final Widget? right;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ThemeExtension.of(context).pageMargin.copyWith(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: ThemeExtension.of(context).backgroundVariant, width: 1),
        )
      ),
      child: Row(
        children: <Widget>[
          left??Container(),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: right??Container()
            )
          )
        ]
      )
    );
  }
}