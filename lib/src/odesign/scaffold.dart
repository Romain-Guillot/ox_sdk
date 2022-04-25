import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';


class OScaffold extends StatelessWidget {
  const OScaffold({ 
    Key? key,
    required this.body,
    this.drawer,
    this.safeArea = true,
    this.appBar
  }) : super(key: key);

  final Widget? drawer;
  final Widget body;
  final bool safeArea;
  final PreferredSizeWidget? appBar;

  @override
  Widget build(BuildContext context) {
    Widget effectiveBody = body;
    if (safeArea) {
      effectiveBody = SafeArea(child: effectiveBody);
    }
    Widget child = Row(
      children: [
        if (drawer != null)
          drawer!,
        Expanded(child: effectiveBody)
      ],
    );

    return OverlayColorWrapper(
      child: Scaffold(
        appBar: appBar,
        body: child
      ),
    );
  }
}