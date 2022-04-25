import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class OverlayColorWrapper extends StatelessWidget {
  const OverlayColorWrapper({ 
    Key? key,
    required this.child
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle ?? const SystemUiOverlayStyle(),
      child: child,
    );
  }
}