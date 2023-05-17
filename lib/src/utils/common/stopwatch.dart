import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

enum XStopWatchMode {
  chronometer,
  timer,
}

enum XStopWatchStatus {
  stopped,
  running,
  paused,
}

class XStopWatchState {
  const XStopWatchState({
    required this.status,
    required this.duration,
  });

  final XStopWatchStatus status;
  final Duration? duration;
}

class XStopWatch {
  XStopWatch({
    required this.mode,
  });

  factory XStopWatch.timer() => XStopWatch(mode: XStopWatchMode.timer);

  factory XStopWatch.chronometer() => XStopWatch(mode: XStopWatchMode.chronometer);

  XStopWatchMode? mode;

  Timer? _timer;
  Duration _pausedTotal = const Duration();
  DateTime? _startTime;
  DateTime? _pauseTime;
  Duration _addedTime = const Duration();
  Duration _preset = const Duration();

  final state = BehaviorSubject<XStopWatchState>();

  final status = BehaviorSubject<XStopWatchStatus>();
  XStopWatchStatus __status = XStopWatchStatus.stopped;
  set _status(XStopWatchStatus value) {
    __status = value;
    status.add(__status);
    state.add(XStopWatchState(duration: __elapsed, status: __status));
  }

  final elapsed = BehaviorSubject<Duration?>();
  Duration? __elapsed;
  set _elapsed(Duration? value) {
    __elapsed = value;
    elapsed.add(__elapsed);
    state.add(XStopWatchState(duration: __elapsed, status: __status));
  }

  _handle() {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (_pauseTime != null) {
      _pausedTotal = Duration(milliseconds: now - _pauseTime!.millisecondsSinceEpoch);
    }
    var elapsedInMs = now - (_startTime!.millisecondsSinceEpoch + _addedTime.inMilliseconds) - _pausedTotal.inMilliseconds;
    switch (mode) {
      case XStopWatchMode.chronometer:
        _elapsed = Duration(milliseconds: elapsedInMs + _preset.inMilliseconds);
        break;
      case XStopWatchMode.timer:
        final remainingTime = max(_preset.inMilliseconds - elapsedInMs, 0);
        _elapsed = Duration(milliseconds: remainingTime);
        break;
      default:
    }
  }

  start({Duration preset = const Duration()}) {
    stop();
    _preset = preset;
    _status = XStopWatchStatus.running;
    _startTime = DateTime.now();
    _handle();
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      _handle();
    });
  }

  play() {
    _status = XStopWatchStatus.running;
    _pauseTime = null;
  }

  Duration? pause() {
    _status = XStopWatchStatus.paused;
    _pauseTime = DateTime.now();
    return __elapsed;
  }

  stop() {
    _status = XStopWatchStatus.stopped;
    _elapsed = null;
    _pauseTime = null;
    _addedTime = const Duration();
    _pausedTotal = const Duration();
    _startTime = null;
    _preset = const Duration();
    _timer?.cancel();
  }

  add(Duration duration) {
    _addedTime = _addedTime + duration;
    _handle();
  }

  remove(Duration duration) {
    _addedTime = _addedTime - duration;
    _handle();
  }

  dispose() {
    _timer?.cancel();
    elapsed.close();
    status.close();
    state.close();
  }
}

class OStopWatchBuilder extends StatelessWidget {
  const OStopWatchBuilder({
    Key? key,
    required this.stopwatch,
    required this.builder,
  }) : super(key: key);

  final XStopWatch stopwatch;
  final Widget Function(BuildContext context, XStopWatchStatus state, Duration? value) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<XStopWatchState>(
      stream: stopwatch.state,
      builder: (context, snapshot) {
        final value = snapshot.data;
        return builder(
          context,
          value?.status ?? XStopWatchStatus.stopped,
          value?.duration,
        );
      },
    );
  }
}
