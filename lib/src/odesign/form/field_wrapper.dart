import 'package:flutter/material.dart';
import 'package:ox_sdk/src/xframework/form/form.dart';



class XFieldWrapper extends StatefulWidget {
  const XFieldWrapper({
    Key? key,
    required this.field,
    required this.builder
  }) : super(key: key);

  final XField field;
  final Function(BuildContext context) builder;

  @override
  State<XFieldWrapper> createState() => _XFieldWrapperState();
}

class _XFieldWrapperState extends State<XFieldWrapper> {
  @override
  void initState() {
    super.initState();
    widget.field.addListener((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return  widget.builder(context);
  }
}
