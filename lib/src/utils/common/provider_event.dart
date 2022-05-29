import 'package:flutter/foundation.dart';



class ProviderEvent<T> {
  ProviderEvent();
  ProviderEvent.fromEvent(this.value);
  T? value;
  final List _consumers = <Object>[];

  void add(T value) {
    _consumers.clear();
    this.value = value;
  }

  void remove() {
    _consumers.clear();
    value = null;
  }

  bool hasValue({Object? originator, bool consume = false}) {
    final bool result = value != null && (originator == null || !_consumers.contains(originator));
    if (result && consume) {
      this.consume(originator: originator);
    }
    return result;
  }

  T? consume({Object? originator}) {
    if (value == null || _consumers.contains(originator)) {
      return null;
    }
    final T? result = value;
    if (originator == null) {
      value = null;
    } else {
      _consumers.add(originator);
    }
    return result;
  }
}





enum EventType {
  success,
  error,
}


@immutable
class Event {
  const Event({
    required this.type,
    this.error,
    this.stackTrace
  });

  const Event.success() : this(type: EventType.success, error: null);
  const Event.error(dynamic e, [StackTrace? s]) : this(type: EventType.error, error: e, stackTrace: s);

  final EventType type;
  final dynamic error;
  final StackTrace? stackTrace;
}