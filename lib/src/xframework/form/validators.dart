class XValidators {
  const XValidators._();

  static String? mandatory<T>(T value) {
    if (value == null) {
      return 'Field mandatory';
    }
    if (value is String && value.isEmpty) {
      return 'Field cannot be empty';
    }
    if (value is Iterable && value.isEmpty) {
      return 'Field cannot be empty';
    }
    return null;
  }

  static String? textLimit(String? value, {int? min, int? max}) {
    if (value != null && min != null && value.length < min) {
      return 'Minimum length: $min';
    }
    if (value != null && max != null && value.length > max) {
      return 'Maximum length: $max';
    }

    return null;
  }

  static String? regex(String? value, String regex, [String? example]) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (RegExp(regex).hasMatch(value)) {
      return null;
    }
    return 'Format error ${example == null ? '' : 'e.g. $example'}';
  }

  static String? isDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final parsedDate = DateTime.tryParse(value);
    if (parsedDate != null) {
      return null;
    }
    return 'Not a date (yyyy-MM-dd)';
  }
}
