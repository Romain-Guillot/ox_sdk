import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';

enum OTileDensity {
  normal,
  large,
}

class OTile extends StatelessWidget {
  const OTile({
    Key? key,
    required this.child,
    this.leading,
    this.actions,
    this.onTap,
    this.density = OTileDensity.normal,
    this.trailing,
  }) : super(key: key);

  final Widget? leading;
  final Widget child;
  final List<Widget>? actions;
  final VoidCallback? onTap;
  final OTileDensity density;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: density.padding(context),
        child: Row(
          children: [
            if (leading != null)
              SizedBox(
                width: 45,
                child: Center(child: leading),
              ),
            PaddingSpacer.small(),
            Expanded(child: Align(alignment: Alignment.centerLeft, child: child)),
            if (trailing != null) Flexible(child: trailing!),
            if (actions != null) ...[
              const PaddingSpacer(),
              ...actions!
                  .map((a) => SizedBox(
                        width: 45,
                        child: a,
                      ))
                  .toList()
            ]
          ],
        ),
      ),
    );
  }
}

extension on OTileDensity {
  EdgeInsets padding(BuildContext context) {
    switch (this) {
      case OTileDensity.normal:
        return EdgeInsets.symmetric(
          horizontal: Theme.of(context).paddings.small,
          vertical: Theme.of(context).paddings.small,
        );
      case OTileDensity.large:
        return EdgeInsets.symmetric(
          horizontal: Theme.of(context).paddings.small,
          vertical: Theme.of(context).paddings.medium,
        );
    }
  }
}

class OTileBody extends StatelessWidget {
  const OTileBody({
    Key? key,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title,
        if (subtitle != null) subtitle!,
      ],
    );
  }
}
