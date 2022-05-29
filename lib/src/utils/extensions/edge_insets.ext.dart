import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/themings/theme.dart';


extension EdgeInsetsExt on EdgeInsets {
  withFAB() {
    return copyWith(
      bottom: kFABMarginBottom
    );
  }
}