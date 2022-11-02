import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';


class ONavigationDestination {
  ONavigationDestination({
    required this.icon,
    required this.label,
    this.selectedIcon
  });

  final Widget icon;
  final Widget? selectedIcon;
  final String label;
}

class ONavigation {
  ONavigation({
    required this.destinations,
    required this.selectedDestination,
    required this.onDestinationChange
  });

  final int selectedDestination;
  final Function(int destination) onDestinationChange;
  final List<ONavigationDestination> destinations;
}


class OScaffold extends StatelessWidget {
  const OScaffold({ 
    Key? key,
    required this.body,
    this.navigation,
    this.safeArea = true,
    this.appBar,
    this.floatingActions,
    this.appName
  }) : super(key: key);

  final ONavigation? navigation;
  final Widget body;
  final bool safeArea;
  final PreferredSizeWidget? appBar;
  final List<Widget>? floatingActions;
  final Widget? appName;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget? bottomNavigationBar;
        Widget effectiveBody = body;
        if (safeArea) {
          effectiveBody = SafeArea(child: effectiveBody);
        }
        final isWide = constraints.maxWidth > Theme.of(context).constraints.mobileScreenMax;
        if (isWide) {
          effectiveBody = Row(
            children: [
              if (navigation != null)
                ODrawer(
                  title: appName ?? Container(),
                  actions: floatingActions,
                  onDestinationChange: navigation!.onDestinationChange,
                  selectedIndex: navigation!.selectedDestination,
                  destinations: navigation!.destinations.map((page) => OMenuDestination(
                    icon: page.icon,
                    selectedIcon: page.selectedIcon,
                    label: Text(page.label),
                  )).toList(),
                ),
              Expanded(child: effectiveBody)
            ],
          );
        } else {
          if (navigation != null) {
            bottomNavigationBar = NavigationBar(
              selectedIndex: navigation!.selectedDestination,
              onDestinationSelected: navigation!.onDestinationChange,
              destinations: navigation!.destinations.map((d) => NavigationDestination(
                icon: d.icon,
                selectedIcon: d.selectedIcon,
                label: d.label,
              )).toList()
            );
          }
          
        }

        return OverlayColorWrapper(
          child: Scaffold(
            appBar: appBar,
            floatingActionButton: isWide
              ? null
              : floatingActions?.first,
            bottomNavigationBar: bottomNavigationBar,
            body: effectiveBody
          ),
        );
      }
    );
  }
}