import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/snackbar.dart';



class ProviderEvent<T> {
  ProviderEvent({
    this.notify,
  });
  ProviderEvent.fromEvent(this.value, {
    this.notify,
  });

  T? value;
  final List _consumers = <Object>[];
  final Function? notify;


  void add(T value) {
    _consumers.clear();
    this.value = value;
    notify?.call();
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
class DataEvent<T, K> {

  const DataEvent.success(this.success) : error = null;
  const DataEvent.error(this.error) : success = null;

  final T? success;
  final K? error;
}


ScaffoldFeatureController? showDataEvent<T, K>(BuildContext context, {
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
  const EventDescription({
    required this.title,
    this.message
  });

  final String title;
  final String? message;
}