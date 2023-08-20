import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension NumFormat on num {
  String format(BuildContext context, {int decimal = 2}) {
    // if (toString().length <= 4) {
    //   return toString();
    // }

    final numberFormatter = NumberFormat(null, Localizations.localeOf(context).languageCode);
    numberFormatter.minimumFractionDigits = 0;
    numberFormatter.maximumFractionDigits = decimal;

    num value = this;
    if (decimal == 0) {
      value = value.round();
    }
    var result = numberFormatter.format(value);
    final withoutGroupSep = result.replaceAll(numberFormatter.symbols.GROUP_SEP, '');
    if (withoutGroupSep.length <= 4) {
      result = withoutGroupSep;
    }

    return result;
  }

  bool isGreaterThan(num other) {
    return this > other;
  }

  bool isGreaterOrEqualThan(num other) {
    return this >= other;
  }

  bool isLessThan(num other) {
    return this < other;
  }

  bool isLessOrEqualThan(num other) {
    return this <= other;
  }
}

extension StringNumFormatted on String {
  num? tryParse(BuildContext context) {
    final numberFormatter = NumberFormat(null, Localizations.localeOf(context).languageCode);
    try {
      return numberFormatter.parse(this);
    } catch (e) {
      return null;
    }
  }
}
