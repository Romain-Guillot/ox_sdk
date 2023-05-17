import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';

class ODialog extends StatelessWidget {
  const ODialog({Key? key, this.title, required this.content, this.noPadding = false, this.actions, this.scrollable = true, this.bottomActions})
      : super(key: key);

  final Widget? title;
  final Widget content;
  final bool noPadding;
  final List<Widget>? actions;
  final bool scrollable;
  final List<Widget>? bottomActions;

  @override
  Widget build(BuildContext context) {
    final padding = Theme.of(context).paddings.medium;
    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: AlertDialog(
            titlePadding: EdgeInsets.zero,
            scrollable: scrollable,
            title: DefaultTextStyle.merge(
                style: Theme.of(context).appBarTheme.titleTextStyle,
                child: Container(
                  padding: EdgeInsets.only(top: padding / 2, bottom: padding / 2, right: padding),
                  child: Row(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(width: 26 + padding * 2),
                        child: IconTheme.merge(
                          data: const IconThemeData(size: 26),
                          child: const CloseButton(),
                        ),
                      ),
                      Expanded(child: title ?? Container()),
                      if (actions != null)
                        ...actions!
                            .map((action) => Padding(
                                  padding: actions!.last == action ? EdgeInsets.zero : EdgeInsets.only(right: Theme.of(context).paddings.small),
                                  child: action,
                                ))
                            .toList()
                    ],
                  ),
                )),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            contentPadding: noPadding ? EdgeInsets.zero : EdgeInsets.all(padding).copyWith(top: 0),
            contentTextStyle: Theme.of(context).textTheme.bodyMedium,
            content: content,
            actions: bottomActions,
            actionsAlignment: MainAxisAlignment.end,
          ),
        ),
      ),
    );
  }
}

enum OConfirmationDialogStyle { confirmation, danger }

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
  Widget confirmIcon;
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
      confirmIcon = const Icon(Icons.warning_amber_rounded);
      cancelIcon = null;
      break;
  }
  bool? confirmation = await showDialog<bool>(
    context: context,
    builder: (context) => ODialog(
      title: title,
      content: content,
      bottomActions: [
        if (cancelIcon == null)
          FilledButton(
            style: cancelStyle,
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: nokLabel,
          )
        else
          FilledButton.icon(
            style: cancelStyle,
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: cancelIcon,
            label: nokLabel,
          ),
        FilledButton.icon(
          style: confirmStyle,
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: confirmIcon,
          label: okLabel,
        ),
      ],
    ),
  );
  return confirmation ?? false;
}
