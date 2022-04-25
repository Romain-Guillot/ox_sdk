
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ox_sdk/src/odesign/draggable_indicator.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/padding_spacer.dart';



class ODraggableSheet extends StatefulWidget {
  const ODraggableSheet({
    Key? key,
    required this.header,
    required this.body
  }) : super(key: key);

  final Widget header;
  final Widget body;

  @override
  State<ODraggableSheet> createState() => _ODraggableSheetState();
}

class _ODraggableSheetState extends State<ODraggableSheet> {
  final headerKey = GlobalKey();
  Size? headerSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        headerSize = headerKey.currentContext?.size;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).appBarTheme.systemOverlayStyle?.copyWith(
        systemNavigationBarColor: Theme.of(context).colorScheme.surface
      ) ?? const SystemUiOverlayStyle(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final initialHeight = headerSize?.height == null ? 0.15 : (headerSize!.height / constraints.maxHeight);
          return DraggableScrollableSheet(
            key: ObjectKey(headerSize ?? this),
            initialChildSize: initialHeight,
            minChildSize: initialHeight,
            builder: (context, scrollController) {
              return Material(
                shape: RoundedRectangleBorder(
                  borderRadius: ThemeExtension.of(context).bigBorderRadius.copyWith(
                    bottomRight: Radius.zero, bottomLeft: Radius.zero
                  )
                ),
                color: Theme.of(context).colorScheme.surface,
                child: SingleChildScrollView(
                controller: scrollController,
                  child: Column(
                    children: [
                      Container(
                        key: headerKey,
                        child: Column(
                          children: [
                            const DraggableIndicator(),
                            widget.header,
                            const PaddingSpacer(),
                          ],
                        ),
                      ),
                      widget.body
                    ],
                  )
                ),
              );
            }
          );
        }
      ),
    );
  }
}

