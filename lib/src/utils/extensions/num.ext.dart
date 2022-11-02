import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension NumFormat on num {
  String format(BuildContext context) {
    // if (toString().length <= 4) {
    //   return toString();
    // }
    
    final numberFormatter = NumberFormat(null, Localizations.localeOf(context).languageCode);
    numberFormatter.minimumFractionDigits = 0;
    var result = numberFormatter.format(this);
    final withoutGroupSep = result.replaceAll(numberFormatter.symbols.GROUP_SEP, '');
    if (withoutGroupSep.length <= 4) {
      result = withoutGroupSep;
    }
    return result;
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