import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

enum DateFormatType {
  date,
  dateShort,
  writtenDate,
  datetimeShort,
  datetimeFull,
}

extension DateFormatExt on DateTime {
  String format(BuildContext context, DateFormatType type) {
    final locale = Localizations.localeOf(context).languageCode;
    final DateFormat effectiveDF;
    switch (type) {
      case DateFormatType.date:
        effectiveDF = DateFormat.yMd(locale);
        break;
      case DateFormatType.dateShort:
        effectiveDF = DateFormat.MMMd(locale);
        break;
      case DateFormatType.datetimeFull:
        effectiveDF = DateFormat.yMd(locale).add_jms();
        break;
      case DateFormatType.writtenDate:
        effectiveDF = DateFormat.yMMMd(locale);
        break;
      case DateFormatType.datetimeShort:
        effectiveDF = DateFormat.yMd(locale).add_jm();
        break;
    }
    return effectiveDF.format(this);
  }

  String toIso8601OffsetString() {
    final base = toIso8601String();
    if (isUtc) {
      return base;
    }

    final offset = timeZoneOffset;
    final hour = offset.inHours;
    final minute = offset.inMinutes - hour * 60;
    final hh = hour.abs().toString().padLeft(2, '0');
    final mm = minute.abs().toString().padLeft(2, '0');
    final time = '$hh:$mm';

    return base + (offset.inMinutes >= 0 ? '+$time' : '-$time');
  }
}
