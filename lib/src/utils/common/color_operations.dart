import 'dart:math';

import 'package:flutter/cupertino.dart';

/// Class to perform operations on [Color]
class ColorOperations {
  ColorOperations._();
  
  /// darken the [color], [amount] between 0 and 1
  static Color darken(Color color, [double amount = 0.5]) {
    final f = 1 - amount;
    return Color.fromARGB(
        color.alpha,
        (color.red * f).round(),
        (color.green  * f).round(),
        (color.blue * f).round()
    );
  }

  /// lighten the [color], [amount] between 0 and 1
  static Color lighten(Color color, [double amount = 0.5]) {
    return Color.fromARGB(
      color.alpha,
      color.red + ((255 - color.red) * amount).round(),
      color.green + ((255 - color.green) * amount).round(),
      color.blue + ((255 - color.blue) * amount).round()
    );
    
  }

  /// [color] format : #FFFFFF
  static Color parse(String color) {
    return Color(int.parse(color.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static String toHex(Color color) {
    return color.value.toRadixString(16);
  }

  /// from: http://alienryderflex.com/hsp.html
  static bool isDark(Color color) {
    return sqrt(0.299 * (color.red * color.red) + 0.587 * (color.green * color.green) + 0.114 * (color.blue * color.blue)) < 127.5;
  }
}