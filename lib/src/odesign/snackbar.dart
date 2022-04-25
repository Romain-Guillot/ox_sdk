import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';



const EdgeInsets kSnakbarDefaultMargin = EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 10.0);



ScaffoldFeatureController<SnackBar, SnackBarClosedReason>  showSuccessSnackbar({
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
    backgroundColor: ThemeExtension.of(context).successColor,
    content: DefaultTextStyle.merge(
      style: TextStyle(color: ThemeExtension.of(context).onSuccessColor),
      child: content
    ),
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
    backgroundColor: ThemeExtension.of(context).errorColor,
    content: DefaultTextStyle.merge(
      style: TextStyle(color: ThemeExtension.of(context).onErrorColor),
      child: content
    ),
  ));
}