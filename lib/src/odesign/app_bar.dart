import 'package:flutter/material.dart';
import 'package:ox_sdk/ox_sdk.dart';



class OAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions
  }) : super(key: key);

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      leading: leading,
      actions: actions?.map((e) => Padding(
        padding: EdgeInsets.only(
          right: actions!.last == e 
            ? Theme.of(context).margins.normal
            : Theme.of(context).paddings.small,
        ),
        child: Align(child: e)
      )).toList()
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}