import 'package:flutter/material.dart';



class SliverListView extends StatelessWidget {
  const SliverListView({
    Key? key,
    required this.itemBuilder,
    this.seperatorBuilder,
    required this.itemCount,
    this.padding = EdgeInsets.zero,
    this.reversed = false
  }) : super(key: key);

  final EdgeInsets padding;
  final bool reversed;
  final int itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;
  final Widget Function(BuildContext context)? seperatorBuilder;

  int get totalCount => itemCount * 2 - 1;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate( 
          (context, index) {
            if (index.isEven) {
              int effectiveIndex = index;
              if (reversed) {
                effectiveIndex = totalCount - effectiveIndex;
              }
              effectiveIndex = effectiveIndex ~/ 2;
              return itemBuilder(context, effectiveIndex);
            } else {
              return seperatorBuilder?.call(context) ?? Container();
            }
          },
          semanticIndexCallback: (Widget widget, int localIndex) {
            if (localIndex.isEven) {
              return localIndex ~/ 2;
            }
            return null;
          },
          childCount: itemCount * 2 - 1,
          
      )
      ),
    );
  }
}