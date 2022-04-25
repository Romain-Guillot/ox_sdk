import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/button.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';


class ODialog extends StatelessWidget {
  const ODialog({ 
    Key? key,
    this.title,
    required this.content,
    this.noPadding = false,
    this.actions,
    this.scrollable = true,
  }) : super(key: key);

  final Widget? title;
  final Widget content;
  final bool noPadding;
  final List<Widget>? actions;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final padding = ThemeExtension.of(context).mediumComponentPadding;
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      scrollable: scrollable,
      title: title != null 
        ? DefaultTextStyle.merge(
            style: Theme.of(context).textTheme.headlineSmall,
            child: Container(
              padding: EdgeInsets.only(
                top: padding / 2,
                bottom: padding / 2,
                right: padding
              ),
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 26 + padding * 2),
                    child: const IconTheme(
                      data: IconThemeData(size: 26),
                      child: CloseButton()
                    ),
                  ),
                  Expanded(child: title!),
                  if (actions != null)
                    ...actions!.map((action) => Padding(
                      padding: actions!.last == action 
                        ? EdgeInsets.zero 
                        : EdgeInsets.only(right: ThemeExtension.of(context).paddingSmall),
                      child: action,
                    )).toList()
                ],
              ),
            )
          )
        : null,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      contentPadding: noPadding ? EdgeInsets.zero : EdgeInsets.all(padding).copyWith(top: 0),
      contentTextStyle: Theme.of(context).textTheme.bodyText1,
      content: content,
    );
  }
}



Future<bool> showConfirmationDialog({
  required BuildContext context,
  required Widget title,
  required Widget content,
  required Widget okLabel,
  required Widget nokLabel,
}) async {
  bool? confirmation =  await showDialog<bool>(context: context, builder: (context) => ODialog(
    title: title,
    content: content,
    actions: [
      OButton(
        color: ThemeExtension.of(context).errorColor,
        onTap: () {
          Navigator.pop(context, false);
        }, 
        icon: const Icon(Icons.cancel_outlined), 
        label: nokLabel
      ),
      OButton(
        color: ThemeExtension.of(context).successColor,
        onTap: () {
          Navigator.pop(context, true);
        }, 
        icon: const Icon(Icons.check_circle_outline), 
        label: okLabel
      ),
    ],
  ));
  return confirmation??false;
}