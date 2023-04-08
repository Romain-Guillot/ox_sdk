import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';

const EdgeInsets kSnakbarDefaultMargin = EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0);

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccessSnackbar({
  required BuildContext context,
  required Widget content,
  SnackBarAction? action,
  Animation<double>? animation,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    // width: ThemeExtension.of(context).snackbarMaxSize,
    margin: kSnakbarDefaultMargin,
    behavior: SnackBarBehavior.floating,
    action: action,
    animation: animation,
    backgroundColor: Theme.of(context).colors.success,
    content: DefaultTextStyle.merge(style: TextStyle(color: Theme.of(context).colors.onSuccess), child: content),
  ));
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackbar({
  required BuildContext context,
  required Widget content,
  SnackBarAction? action,
  Animation<double>? animation,
}) {
  return ScaffoldMessenger.maybeOf(context)!.showSnackBar(SnackBar(
    // width: ThemeExtension.of(context).snackbarMaxSize.isNaN ? null : ThemeExtension.of(context).snackbarMaxSize,
    margin: kSnakbarDefaultMargin,
    behavior: SnackBarBehavior.floating,
    action: action,
    animation: animation,
    backgroundColor: Theme.of(context).colors.error,
    content: DefaultTextStyle.merge(style: TextStyle(color: Theme.of(context).colors.onError), child: content),
  ));
}
