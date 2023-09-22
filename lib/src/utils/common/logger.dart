import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:ox_sdk/src/utils/common/app_exception.dart';
import 'package:ox_sdk/src/utils/common/cyclic_list.dart';
import 'package:ox_sdk/src/utils/common/sentry_output.dart';

class LogEntry {
  const LogEntry(
    this.emitter,
    this.level,
    this.message, [
    this.exception,
    this.stacktrace,
  ]);

  final String emitter;
  final Level level;
  final dynamic message;
  final dynamic exception;
  final dynamic stacktrace;
}

abstract class XLogger {
  XLogger({
    Type? context,
    String? contextStr,
    LogOutput? logOutput,
    Level logLevel = Level.verbose,
  })  : assert(context != null || contextStr != null),
        _context = context == null ? contextStr! : (context).toString(),
        _logger = Logger(
            filter: logOutput == null ? DevelopmentFilter() : ProductionFilter(),
            level: logLevel,
            printer: PrettyPrinter(printEmojis: false, printTime: false, methodCount: 10, noBoxingByDefault: true),
            output: logOutput);

  final String _context;
  final Logger _logger;

  static var lastEntries = CyclicList<LogEntry>(200, reverse: true);

  void onFlutterError(FlutterErrorDetails details) {
    e(details.exception.toString(), details.exception, details.stack);
  }

  void onError(Object error, StackTrace stack) {
    e(error.toString(), error, stack);
  }

  void exception(String message, AppException exception) {
    e(message, exception.innerException, exception.innerStackTrace);
  }

  /// Log a message at level [Level.verbose].
  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    lastEntries.add(LogEntry(_context, Level.verbose, message, error, stackTrace));
    _logger.v(formatMessage(message), error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.debug].
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    lastEntries.add(LogEntry(_context, Level.debug, message, error, stackTrace));
    _logger.d(formatMessage(message), error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.info].
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    lastEntries.add(LogEntry(_context, Level.info, message, error, stackTrace));
    _logger.i(formatMessage(message), error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.warning].
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    lastEntries.add(LogEntry(_context, Level.warning, message, error, stackTrace));
    _logger.w(formatMessage(message), error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.error].
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    lastEntries.add(LogEntry(_context, Level.error, message, error, stackTrace));
    _logger.e(formatMessage(message), error: error, stackTrace: stackTrace);
  }

  /// Log a message at level [Level.wtf].
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    lastEntries.add(LogEntry(_context, Level.wtf, message, error, stackTrace));
    _logger.wtf(formatMessage(message), error: error, stackTrace: stackTrace);
  }

  String formatMessage(dynamic message) {
    return '$_context > $message';
  }
}

class XLoggerImpl extends XLogger {
  XLoggerImpl({
    Type? context,
    String? contextStr,
  }) : super(
          context: context,
          contextStr: contextStr,
          logLevel: logLevel,
          logOutput: output,
        );

  static LogOutput? output;
  static Level logLevel = Level.debug;
}

typedef AppWrapper = Function(FutureOr<void> Function());

AppWrapper configureLogger({
  required bool useSentry,
  required Level level,
  required String sentryURL,
}) {
  SentryLogOutput? sentryOuput;
  if (useSentry) {
    sentryOuput = SentryLogOutput(baseUrl: sentryURL);
    XLoggerImpl.output = sentryOuput;
  }
  XLoggerImpl.logLevel = level;
  if (sentryOuput != null) {
    return sentryOuput.configure;
  } else {
    return (FutureOr<void> Function() appRunner) => appRunner();
  }
}
