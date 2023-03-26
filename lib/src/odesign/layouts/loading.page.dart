import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/loading_indicator.dart';

class OLoadingPage extends StatelessWidget {
  const OLoadingPage({
    super.key,
    this.label,
  });

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OLoadingIndicator(
        label: label,
      ),
    );
  }
}
