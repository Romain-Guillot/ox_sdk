import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';


class DismissibleHeaderLayout extends StatelessWidget {
  const DismissibleHeaderLayout({ 
    Key? key,
    required this.header,
    required this.body,
    this.headerBackground,
    this.headerPadding,
  }) : super(key: key);

  final Widget header;
  final Widget body;
  final Color? headerBackground;
  final EdgeInsets? headerPadding;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder:  (context, innerBoxIsScrolled) => [
        SliverToBoxAdapter(
          child: Material(
            color: headerBackground ?? Theme.of(context).colorScheme.background,
            child: Padding(
              padding: headerPadding ?? EdgeInsets.symmetric(
                horizontal: Theme.of(context).margins.normal,
                vertical : Theme.of(context).paddings.medium
              ),
              child: header
            ),
          ),
      )],
      body: body
    );
  }
}