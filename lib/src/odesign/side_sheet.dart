import 'package:flutter/material.dart';


Future<T?> showSideSheet<T extends Object?>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  bool rightSide = true,
}) {
  return showGeneralDialog<T>(
    barrierLabel: 'Barrier',
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: rightSide ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          height: double.infinity,
          width: 700,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: builder(context),
        ),
      );
    },
    transitionBuilder: (context, animation1, animation2, child) {
      return SlideTransition(
        position:
            Tween<Offset>(
              begin: Offset(rightSide ? 1 : -1, 0), 
              end: const Offset(0, 0)
            ).animate(animation1),
        child: child,
      );
    },
  );
}