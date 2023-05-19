import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ox_sdk/src/utils/common/app_exception.dart';

Future<T> callApiOrThrow<T>(FutureOr<T> Function() func, {void Function(dynamic e, StackTrace s)? onError}) async {
  try {
    try {
      return await func();
    } catch (e, s) {
      if (onError != null) {
        onError(e, s);
      }
      rethrow; // pour être catch par le try catch root
    }
  } on DioError catch (e, s) {
    final statusCode = e.response?.statusCode;
    if (statusCode == null) {
      // si la réponse est null : dns error, offline, ...
      throw ServerCommunicationError(e);
    } else {
      throw ApiException(code: statusCode, innerException: e, innerStackTrace: s);
    }
  } catch (e) {
    rethrow;
  }
}

class ServerCommunicationError implements Exception {
  ServerCommunicationError(this.error);

  final DioError error;

  @override
  String toString() {
    return error.error?.toString() ?? '';
  }
}
