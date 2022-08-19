import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';


class OMenuDestination {
  const OMenuDestination({
    required this.icon,
    required this.selectedIcon,
    required this.label
  });

  final Widget icon;
  final Widget? selectedIcon;
  final Widget label;
}

typedef OnDestinationChange = void Function(int index);


class ODrawer extends StatefulWidget {
  const ODrawer({ 
    Key? key,
    required this.title,
    required this.selectedIndex,
    this.actions,
    required this.destinations,
    required this.onDestinationChange,
    this.bottom
  }) : super(key: key);

  final Widget title;
  final List<Widget>? actions;
  final int selectedIndex;
  final List<OMenuDestination> destinations;
  final OnDestinationChange onDestinationChange;
  final Widget? bottom;

  @override
  State<ODrawer> createState() => ODrawerState();

  static ODrawerState? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<ODrawerState>();
  }
}

class ODrawerState extends State<ODrawer> {
  bool _opened = true;
  bool get opened => _opened;
  set opened(bool opened) {
    setState(() {
      _opened = opened;
    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = Theme.of(context).paddings.medium;
    return SafeArea(
      child: Container(
        key: GlobalKey(),
        padding: EdgeInsets.only(
          bottom: padding
        ),
        width: opened ? 250 : null,
        height: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: padding / 2,
                      right: padding / 2,
                      top: padding
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconTheme.merge(
                          data: const IconThemeData(size: 38),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(999),
                            onTap: () {
                              opened = !opened;
                            },
                            child: Padding(
                              padding: EdgeInsets.all(padding/2),
                              child: Icon(opened 
                                ? Icons.menu_open_outlined
                                : Icons.menu_outlined
                              ),
                            )
                          )
                          
                        ),
                        if (opened)
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: padding / 2,
                              ),
                              child: Center(child: widget.title),
                            ),
                          )
                      ],
                    ),
                  ),
                  if (widget.actions != null)
                    Padding(
                      padding: EdgeInsets.only(
                        top: Theme.of(context).paddings.big,
                        left: padding,
                        right: padding
                      ),
                      child: Column(
                        children: widget.actions!.map(
                          (action) => Padding(
                            padding: widget.actions?.last == action 
                              ? EdgeInsets.zero
                              : EdgeInsets.only(bottom: Theme.of(context).paddings.small),
                            child: action,
                          )
                        ).toList()
                      ) ,
                    ),
                ],
              ),
            ),
            
            Positioned(
              child: Align(
                alignment: Alignment.centerRight,
                child:  Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: padding
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...widget.destinations.map((destination) {
                        final index = widget.destinations.indexOf(destination);
                        final isEndChild = index == (widget.destinations.length -1 );
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: isEndChild 
                              ? 0.0 
                              : (Theme.of(context).paddings.small)
                          ),
                          child: _DestinationItemWidget(
                            destination: destination,
                            wide: opened,
                            selected: index == widget.selectedIndex,
                            onTap: () => widget.onDestinationChange(index),
                          ),
                        );
                      }).toList()
                    ]
                  )
                ),
              )
            ),
            if (widget.bottom != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: padding
                  ),
                  child: widget.bottom!
                )
              )
          ]
        ),
      ),
    );
  }
}

class _DestinationItemWidget extends StatelessWidget {
  const _DestinationItemWidget({ 
    Key? key,
    required this.destination,
    required this.onTap,
    required this.selected,
    required this.wide,
  }) : super(key: key);

  final OMenuDestination destination;
  final bool selected;
  final bool wide;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).navigationRailTheme;
    return Material(
      color: selected ? theme.indicatorColor : Colors.transparent,
      borderRadius: Theme.of(context).radiuses.small,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(Theme.of(context).paddings.small),
          child: Row(
            children: [
              IconTheme.merge(
                data: const IconThemeData().merge(selected 
                  ? theme.selectedIconTheme
                  : theme.unselectedIconTheme),
                child: selected 
                  ? (destination.selectedIcon ?? destination.icon)
                  : destination.icon
              ),
              if (wide)...[
                const PaddingSpacer(),
                DefaultTextStyle.merge(
                  style: selected 
                    ? theme.selectedLabelTextStyle
                    : theme.unselectedLabelTextStyle,
                  child: destination.label
                ),
              ]     
            ],
          ),
        ),
      ),
    );
  }
}