class AppException implements Exception  {
  const AppException({
    required this.code,
    this.innerException,
    this.innerStackTrace
  });

  final int code;
  final dynamic innerException;
  final StackTrace? innerStackTrace;

  @override
  String toString() => 'AppException : $code';
}

class AppExceptionDescription {
  const AppExceptionDescription(
    this.title,
    [this.message]
  );

  final String title;
  final String? message;
}


class ApiException implements Exception {
  const ApiException({
    required this.code,
    this.innerException,
    this.innerStackTrace
  });

  final int code;
  final dynamic innerException;
  final StackTrace? innerStackTrace;

  @override
  String toString() {
    return 'Api exception: $code';
  }
}