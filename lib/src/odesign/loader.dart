import 'package:flutter/material.dart';


enum OLoaderSize {
  big,
  normal,
  small
}


class OLoader extends StatelessWidget {
  const OLoader({ 
    Key? key,
    this.size = OLoaderSize.normal
  }) : super(key: key);

  final OLoaderSize size;

  @override
  Widget build(BuildContext context) {
    final props = size.properties();
    return SizedBox.square(
      dimension: props.height,
      child: FittedBox(
        child: CircularProgressIndicator(
          strokeWidth: props.strokeWidth,
        ),
      ),
    );
  }
}



class _LoaderProperties {
  const _LoaderProperties(this.strokeWidth, this.height);

  final double strokeWidth;
  final double height;
}



extension on OLoaderSize {
  _LoaderProperties properties() {
    switch (this) {
      case OLoaderSize.big:
        return const _LoaderProperties(7, 20);
      case OLoaderSize.normal:
        return const _LoaderProperties(6, 20);
      case OLoaderSize.small:
        return const  _LoaderProperties(5, 20);
    }
  }
}