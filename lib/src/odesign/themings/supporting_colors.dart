import 'package:flutter/material.dart';

enum SupportingColors {
  red,
  purple,
  green,
  yellow,
  blue,
  orange,
  pink,
  indigo,
  turqoise,
  eucalyptus,
  sand
}


class SupportingColorData {
  const SupportingColorData({
    required this.primary,
    required this.onPrimary,
    required this.variant,
    required this.onVariant,
    required this.container,
    required this.onContainer
  });

  final Color primary;
  final Color onPrimary;
  final Color variant;
  final Color onVariant;
  final Color container;
  final Color onContainer;
}

 