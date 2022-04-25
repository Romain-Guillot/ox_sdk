
import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';


class OSwitchBar extends StatelessWidget {
  const OSwitchBar({
    Key? key,
    required this.tabs
  }) : super(key: key);

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Theme.of(context).colorScheme.onPrimary,
      indicatorColor: Theme.of(context).colorScheme.primary,
      unselectedLabelColor: Theme.of(context).colorScheme.primary,
      indicatorSize: TabBarIndicatorSize.label,
      padding: EdgeInsets.zero,
      indicatorPadding: EdgeInsets.zero,
      indicatorWeight: 0,
      indicator: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: ThemeExtension.of(context).smallBorderRadius,
      ),
      tabs: tabs
    );
  }
}


class OTab extends StatelessWidget {
  const OTab({
    Key? key,
    required this.label
  }) : super(key: key);

  final Widget label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8
      ),
      child: label,
    );
  }
}