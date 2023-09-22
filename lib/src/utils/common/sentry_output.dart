import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:logger/logger.dart';

class SentryLogOutput extends LogOutput {
  SentryLogOutput({required this.baseUrl});

  final String baseUrl;

  Future<void> configure(AppRunner appRunner) async {
    await SentryFlutter.init(
      (options) {
        options.dsn = baseUrl;
      },
      appRunner: appRunner,
    );
  }

  @override
  void output(OutputEvent event) {
    Sentry.captureMessage(
      event.lines.join('\n'),
      level: event.level.toSentry(),
    );
  }
}

extension on Level {
  SentryLevel toSentry() {
    switch (this) {
      case Level.debug:
        return SentryLevel.debug;
      case Level.info:
        return SentryLevel.info;
      case Level.verbose:
        return SentryLevel.debug;
      case Level.nothing:
        return SentryLevel.debug;
      case Level.wtf:
        return SentryLevel.error;
      case Level.error:
        return SentryLevel.error;
      case Level.warning:
        return SentryLevel.warning;
      case Level.all:
        return SentryLevel.debug;
      case Level.trace:
        return SentryLevel.debug;
      case Level.fatal:
        return SentryLevel.error;
      case Level.off:
        return SentryLevel.error;
    }
  }
}
