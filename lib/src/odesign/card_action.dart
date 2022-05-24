import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';


class OCardAction extends StatelessWidget {
  const OCardAction({ 
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final Widget icon;
  final Widget label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: Theme.of(context).radiuses.medium,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 125,
          height: 125,
          child: Stack(
            children: [
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Padding(
                    padding: const EdgeInsets.all(8).copyWith(bottom: 8 + 10),
                    child: icon,
                  )
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0
                    ),
                    child: DefaultTextStyle.merge(
                      style: Theme.of(context).textTheme.labelLarge,
                      child: label
                    ),
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}