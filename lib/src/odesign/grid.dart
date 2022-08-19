import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:sliver_tools/sliver_tools.dart';


enum OColumnSortOrder {
  asc,
  desc
}


typedef OnSortColumn = Function(OColumnSortOrder order);
typedef ColumnRenderer<T> = Widget Function(int index, T data);


class OGridColumn<T> {
  const OGridColumn({
    required this.key,
    this.label,
    this.child,
    required this.renderer,
    this.onSort,
    this.weight = 1,
    this.width,
    this.alignment = Alignment.centerLeft,
    this.isDefaultSortOrder = false
  }) : assert((label != null || child != null) && (label == null || child == null));

  final Key key;
  final Widget? child;
  final String? label;
  final ColumnRenderer<T> renderer;
  final OnSortColumn? onSort;
  final int weight;
  final Alignment alignment;
  final bool isDefaultSortOrder;
  final double? width;

  @override
  bool operator ==(other) {
    if (other is! OGridColumn) {
      return false;
    }
    return (other.key == key);
  }

  @override
  int get hashCode => key.hashCode;

}

class OGridColumnSpacer<T> extends OGridColumn<T> {
  OGridColumnSpacer([double? width]) : super(
    key: GlobalKey(),
    width:  width ?? 15.0,
    label: '',
    renderer: (_, __) => Container()
  );
}


class OGridHeaderStyle {
  const OGridHeaderStyle({
    this.decoration,
    this.textStyle,
    this.verticalSpacing
  });

  final TextStyle? textStyle;
  final double? verticalSpacing;
  final Decoration? decoration;
}


class GridRowStyle {
  const GridRowStyle({
    required this.padding,
    this.decoration,
    this.minHeight,
  });

  final EdgeInsets Function(VisualDensity density) padding;
  final Decoration? decoration;
  final double Function(VisualDensity density)? minHeight;
}


class ODataGridTheme {
  const ODataGridTheme({
    this.headerStyle,
    this.rowStyle
  });

  final OGridHeaderStyle? headerStyle;
  final GridRowStyle? rowStyle;
}

class _Header<T> extends StatefulWidget {
  const _Header({ 
    Key? key,
    required this.theme,
    required this.columns,
    required this.density
  }) : super(key: key);

  final VisualDensity density;
  final ODataGridTheme? theme;
  final List<OGridColumn<T>> columns;

  @override
  __HeaderState createState() => __HeaderState<T>();
}

class __HeaderState<T> extends State<_Header<T>> {

  OGridColumn<T>? sortColumn;
  OColumnSortOrder? sortOrder;

  ODataGridTheme? get theme => widget.theme;
  List<OGridColumn<T>> get columns => widget.columns;

  @override
  void initState() {
    super.initState();
    sortColumn = columns.firstWhereOrNull((e) => e.isDefaultSortOrder == true);
    if (sortColumn != null) {
      sortOrder = OColumnSortOrder.asc;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget header = DefaultTextStyle.merge(
      style: theme?.headerStyle?.textStyle ?? Theme.of(context).textTheme.subtitle1!,
      child: Builder(builder: (BuildContext context) => Row(
      children: columns.map((OGridColumn<T> column) {
        Widget child = column.child != null 
          ? column.child!
          : AutoSizeText(
              column.label!, 
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            );
        if (column.onSort != null) {
          child =  InkWell(
            onTap: () {
              setState(() {
                sortColumn = column;
                if (sortColumn == column) {
                  sortOrder = sortOrder == OColumnSortOrder.asc ? OColumnSortOrder.desc : OColumnSortOrder.asc;
                } else {
                  sortOrder = OColumnSortOrder.asc;
                }
                sortColumn?.onSort?.call(sortOrder!);
              });

            },
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                child,
                Icon(
                  sortColumn == column 
                    ? (sortOrder == OColumnSortOrder.desc ? Icons.arrow_drop_up : Icons.arrow_drop_down)
                    : Icons.arrow_drop_down,
                  color: sortColumn == column 
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).disabledColor
                )
              ],
            ),
          );
        }
        final isFixed = column.width != null;
        child = Align(
          alignment: column.alignment,
          child: child
        );
        if (isFixed) {
          return SizedBox(
            width: column.width,
            child: child
          );
        } else {
          return Expanded(
            flex: column.weight,
            child: child
          );
        }
      },
      ).toList(),
      )
    ));

    header = Container(
      padding: EdgeInsets.symmetric(
        vertical: theme?.headerStyle?.verticalSpacing??0.0,
        horizontal: (theme?.rowStyle?.padding(widget.density).horizontal ?? 0) / 2
      ),
      child: header,
    );


    if (theme?.headerStyle?.decoration != null) {
      header = Container(
        decoration: theme?.headerStyle?.decoration,
        child: Material(
          color: Theme.of(context).colorScheme.surface,
          child: header
        ),
      );
    }

    return header;
  }
}

enum OGridHeaderBehavior {
  fixed,
  hide,
}

class ODataGrid<T> extends StatelessWidget {
  const ODataGrid({
    Key? key,
    required this.columns,
    required this.values,
    this.theme,
    this.onClick,
    this.headerBeahavior = OGridHeaderBehavior.fixed,
    this.primary = true,
    this.scrollPhysics,
    this.density = VisualDensity.standard
  }) : super(key: key);

  final List<OGridColumn<T>> columns;
  final List<T> values;
  final Function(T)? onClick;
  final ODataGridTheme? theme;
  final OGridHeaderBehavior headerBeahavior;
  final bool primary;
  final ScrollPhysics? scrollPhysics;
  final VisualDensity density;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = Theme.of(context).components.dataGrid ?? theme;
    Widget child = MultiSliver(
      children: <Widget>[
        if (headerBeahavior != OGridHeaderBehavior.hide)
          SliverPinnedHeader(
            child: _Header(
              theme: effectiveTheme,
              columns: columns,
              density: density,
            )
          ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final T item = values[index];
              Widget child = Container(
                decoration: effectiveTheme?.rowStyle?.decoration,
                constraints: BoxConstraints(
                  minHeight: effectiveTheme?.rowStyle?.minHeight?.call(density) ?? 0.0
                ),
                padding: effectiveTheme?.rowStyle?.padding.call(density) ?? EdgeInsets.zero,
                child: DefaultTextStyle.merge(
                  style: Theme.of(context).textTheme.bodySmall,
                  child: Row(
                    children: columns.map((OGridColumn<T> column) {
                      final isFixed = column.width != null;
                      final child = Align(
                        alignment: column.alignment,
                        child: column.renderer(index, item)
                      );
                      if (isFixed) {
                        return SizedBox(
                          width: column.width,
                          child: child
                        );
                      } else {
                        return Expanded(
                          flex: column.weight,
                          child: child
                        );
                      }
                      
                    }).toList(),
                  ),
                ),
              );
              if (onClick != null) {
                child = InkWell(
                  onTap: () => onClick!.call(item),
                  child: child,
                );
              }
              return Material(
                color: Colors.transparent,
                child: child
              );
            },
            childCount: values.length,
          )
        )
      ],
    );
    if (primary == true) {
      child = CustomScrollView(
        physics: scrollPhysics,
        slivers: [
          child,
        ],
      );
    }

    return child;
  }
}
