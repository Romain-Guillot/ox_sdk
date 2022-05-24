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
    this.bottomActions
  }) : super(key: key);

  final Widget? title;
  final Widget content;
  final bool noPadding;
  final List<Widget>? actions;
  final bool scrollable;
  final List<Widget>? bottomActions;

  @override
  Widget build(BuildContext context) {
    final padding = Theme.of(context).paddings.medium;
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      scrollable: scrollable,
      title: title != null || actions != null 
        ? DefaultTextStyle.merge(
            style: Theme.of(context).appBarTheme.titleTextStyle,
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
                  Expanded(child: title ?? Container()),
                  if (actions != null)
                    ...actions!.map((action) => Padding(
                      padding: actions!.last == action 
                        ? EdgeInsets.zero 
                        : EdgeInsets.only(
                            right: Theme.of(context).paddings.small
                          ),
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
      actions: bottomActions,
      actionsAlignment: MainAxisAlignment.end,
      
    );
  }
}



enum OConfirmationDialogStyle {
  confirmation,
  danger
}


Future<bool> showConfirmationDialog({
  required BuildContext context,
  Widget? title,
  OConfirmationDialogStyle mode = OConfirmationDialogStyle.confirmation,
  required Widget content,
  required Widget okLabel,
  required Widget nokLabel,
}) async {
  ButtonStyle? confirmStyle;
  ButtonStyle? cancelStyle;
  Widget? confirmIcon;
  Widget? cancelIcon;
  switch (mode) {
    case OConfirmationDialogStyle.confirmation:
      confirmStyle = Theme.of(context).buttons.success;
      cancelStyle = Theme.of(context).buttons.error;
      confirmIcon = const Icon(Icons.check_circle_outline);
      cancelIcon = const Icon(Icons.cancel_outlined);
      break;
    case OConfirmationDialogStyle.danger:
      confirmStyle = Theme.of(context).buttons.error;
      confirmIcon = const Icon(Icons.warning_amber_outlined);
      cancelIcon = null;
      break;
  }
  bool? confirmation =  await showDialog<bool>(context: context, builder: (context) => ODialog(
    title: title,
    content: content,
    bottomActions: [
      OButton(
        style: OButtonStyle.secondary,
        buttonStyle: cancelStyle,
        onTap: () {
          Navigator.pop(context, false);
        }, 
        icon: cancelIcon, 
        label: nokLabel
      ),
      OButton(
        style: OButtonStyle.primary,
        buttonStyle: confirmStyle,        
        onTap: () {
          Navigator.pop(context, true);
        }, 
        icon: confirmIcon, 
        label: okLabel
      ),
    ],
  ));
  return confirmation??false;
}