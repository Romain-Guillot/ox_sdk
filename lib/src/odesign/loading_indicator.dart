import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';

class OLoadingIndicator extends StatelessWidget {
  const OLoadingIndicator({super.key, this.label});

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          if (label != null)
            DefaultTextStyle.merge(
              style: Theme.of(context).textTheme.bodyText1,
              child: Padding(padding: EdgeInsets.only(left: Theme.of(context).paddings.medium), child: label),
            )
        ],
      ),
    );
  }
}
