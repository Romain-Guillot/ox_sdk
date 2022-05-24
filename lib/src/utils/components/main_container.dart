import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';


class MainContainer extends StatelessWidget {
  const MainContainer({
    Key? key,
    required this.child
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        constraints: BoxConstraints(
          maxWidth: Theme.of(context).constraints.maxPageWidth 
        ),
        child: child
      ),
    );
  }
}