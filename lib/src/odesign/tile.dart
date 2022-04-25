import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';


class OTile extends StatelessWidget {
  const OTile({ 
    Key? key ,
    required this.child,
    this.leading,
    this.actions
  }) : super(key: key);

  final Widget? leading;
  final Widget child;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ThemeExtension.of(context).paddingSmall,
        vertical: ThemeExtension.of(context).paddingSmall
      ),
      child: Row(
        children: [
          if (leading != null)
            SizedBox(
              width: 45,
              child: Center(child: leading),
            ),
          PaddingSpacer.small(),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: child
            )
          ),
          if (actions != null)...[
            const PaddingSpacer(),
            ...actions!.map((a) => SizedBox(
              width: 45,
              child: a,
            )).toList()
          ]
        ],
      ),
    );
  }
}