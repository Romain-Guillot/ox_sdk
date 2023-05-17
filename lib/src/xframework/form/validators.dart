class XValidators {
  const XValidators._();

  static XValidatorError? selectLimit<T>(List<T>? value, {int? min, int? max}) {
    if (value != null && min != null && value.length < min) {
      return XValidatorErrorSelectLimit(XValidatorErrorSelectLimitCause.tooSort, value.length, min, max);
    }
    if (value != null && max != null && value.length > max) {
      return XValidatorErrorSelectLimit(XValidatorErrorSelectLimitCause.tooLong, value.length, min, max);
    }

    return null;
  }

  static XValidatorError? mandatory<T>(T value) {
    if (value == null) {
      return XValidatorErrorMandatory(XValidatorErrorMandatoryCause.notDefinedValue);
    }
    if (value is String && value.isEmpty) {
      return XValidatorErrorMandatory(XValidatorErrorMandatoryCause.emptyString);
    }
    if (value is Iterable && value.isEmpty) {
      return XValidatorErrorMandatory(XValidatorErrorMandatoryCause.emptyIterable);
    }
    return null;
  }

  static XValidatorError? textLimit(String? value, {int? min, int? max}) {
    if (value != null && min != null && value.length < min) {
      return XValidatorErrorTextLimit(XValidatorErrorTextLimitCause.tooSort, value.length, min, max);
    }
    if (value != null && max != null && value.length > max) {
      return XValidatorErrorTextLimit(XValidatorErrorTextLimitCause.tooLong, value.length, min, max);
    }

    return null;
  }

  static XValidatorError? regex(String? value, String regex, [String? example]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (RegExp(regex).hasMatch(value)) {
      return null;
    }
    return XValidatorErrorRegex(regex, example);
  }

  static XValidatorError? isDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final parsedDate = DateTime.tryParse(value);
    if (parsedDate != null) {
      return null;
    }
    return XValidatorErrorDateFormat('yyyy-MM-dd');
  }
}

sealed class XValidatorError {}

enum XValidatorErrorSelectLimitCause {
  tooLong,
  tooSort,
}

class XValidatorErrorSelectLimit implements XValidatorError {
  XValidatorErrorSelectLimit(this.cause, this.current, this.min, this.max);

  final XValidatorErrorSelectLimitCause cause;
  final int current;
  final int? min;
  final int? max;
}

enum XValidatorErrorMandatoryCause {
  notDefinedValue,
  emptyString,
  emptyIterable,
}

class XValidatorErrorMandatory implements XValidatorError {
  XValidatorErrorMandatory(this.cause);

  final XValidatorErrorMandatoryCause cause;
}

enum XValidatorErrorTextLimitCause {
  tooLong,
  tooSort,
}

class XValidatorErrorTextLimit implements XValidatorError {
  XValidatorErrorTextLimit(this.cause, this.current, this.min, this.max);

  final XValidatorErrorTextLimitCause cause;
  final int current;
  final int? min;
  final int? max;
}

class XValidatorErrorRegex implements XValidatorError {
  XValidatorErrorRegex(this.regex, [this.example]);

  final String regex;
  final String? example;
}

class XValidatorErrorDateFormat implements XValidatorError {
  XValidatorErrorDateFormat(this.format);

  final String format;
}
