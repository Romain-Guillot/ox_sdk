import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class WidgetImageConverterController {
  GlobalKey containerKey = GlobalKey();

  Future<Uint8List?> convert() async {
    final boundary = containerKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image = await boundary!.toImage(pixelRatio: 6);

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData?.buffer.asUint8List();
    return pngBytes;
  }
}

class WidgetImageConverter extends StatelessWidget {
  const WidgetImageConverter({
    Key? key,
    required this.child,
    required this.controller,
  }) : super(key: key);

  final Widget? child;
  final WidgetImageConverterController controller;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: controller.containerKey,
      child: child,
    );
  }
}
