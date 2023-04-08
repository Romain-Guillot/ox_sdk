import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/snackbar.dart';

class ProviderEvent<T> {
  ProviderEvent(this.notify);
  ProviderEvent.fromEvent(T value, this.notify) : _value = value;

  T? _value;

  final List _consumers = <Object>[];
  final Function? notify;

  void add(T value) {
    _consumers.clear();
    _value = value;
    notify?.call();
  }

  void remove() {
    _consumers.clear();
    _value = null;
    notify?.call();
  }

  bool hasValue({Object? originator, bool consume = false}) {
    final bool result = _value != null && (originator == null || !_consumers.contains(originator));
    if (result && consume) {
      this.consume(originator: originator);
    }
    return result;
  }

  T? consume({Object? originator}) {
    if (_value == null || _consumers.contains(originator)) {
      return null;
    }
    final T? result = _value;
    if (originator == null) {
      _value = null;
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
class DataEvent<T, K> {
  const DataEvent.success(this.success) : error = null;
  const DataEvent.error(this.error) : success = null;

  final T? success;
  final K? error;
}

ScaffoldFeatureController? showDataEvent<T, K>(
  BuildContext context, {
  required dynamic originator,
  required ProviderEvent<DataEvent<T, K>> event,
  required String Function(K)? errorBuilder,
  required String Function(T)? succesBuilder,
}) {
  ScaffoldFeatureController? controller;
  if (event.hasValue()) {
    final eventValue = event.consume(originator: originator);
    final error = eventValue?.error;
    final success = eventValue?.success;
    if (errorBuilder != null && error != null) {
      final errorMessage = errorBuilder(error);
      return showErrorSnackbar(context: context, content: Text(errorMessage));
    } else if (succesBuilder != null && success != null) {
      final successMessage = succesBuilder(success);
      return showSuccessSnackbar(context: context, content: Text(successMessage));
    }
  }
  return controller;
}

class EventDescription {
  const EventDescription({required this.title, this.message});

  final String title;
  final String? message;
}
