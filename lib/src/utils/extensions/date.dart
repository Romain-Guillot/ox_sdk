import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

enum DateFormatType {
  date,
  dateShort,
  datetimeShort,
  datetimeFull,
}

extension DateFormatExt on DateTime {
  String format(BuildContext context, DateFormatType type) {
    final locale = Localizations.localeOf(context).languageCode;
    final DateFormat effectiveDF;
    switch (type) {
      case DateFormatType.date:
        effectiveDF=  DateFormat.yMd(locale);
        break;
      case DateFormatType.dateShort:
        effectiveDF=  DateFormat.MMMd(locale);
        break;
      case DateFormatType.datetimeFull:
        effectiveDF = DateFormat.yMd(locale).add_jms();
        break;
      case DateFormatType.datetimeShort:
        effectiveDF = DateFormat.yMd(locale).add_jm();
        break;
    }
    return effectiveDF.format(this);
  }
}