
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
      padding: EdgeInsets.symmetric(
        horizontal: Theme.of(context).margins.normal
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.surface, 
            width: 1
          ),
        )
      ),
      child: Row(
        children: <Widget>[
          left ?? Container(),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: right ?? Container()
            )
          )
        ]
      )
    );
  }
}