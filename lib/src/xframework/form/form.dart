import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:ox_sdk/ox_sdk.dart';

typedef XFieldValidator<T> = XValidatorError? Function(T? value);

abstract class XField<T> {
  XField(T? initialValue)
      : _initialValue = initialValue,
        history = [initialValue];

  T? _initialValue;
  T? get initialValue => _initialValue;

  T? get value;

  List<XFieldValidator<T>>? get validators;

  void setInitialValue(T? initialValue) {
    _initialValue = initialValue;
    setValue(initialValue);
  }

  void setValue(T? newValue);

  void addListener(ValueChanged<T?> callback);

  void removeListener(ValueChanged<T?> callback);

  bool hasChanged();

  bool hasError() {
    return errors() != null && errors()?.isNotEmpty == true;
  }

  List<XValidatorError>? errors() {
    final List<XValidatorError> results = [];
    final validators = this.validators;
    if (validators != null) {
      for (final validator in validators) {
        final error = validator.call(value);
        if (error != null) {
          results.add(error);
        }
      }
    }

    return results;
  }

  bool canUndo() {
    return history.length >= 2;
  }

  List<T?> history;

  void undo() {
    if (canUndo()) {
      final restoredValue = history[history.length - 2];
      history.removeLast();
      setValue(restoredValue);
    }
  }
}

class XTextField extends XField<String> {
  XTextField({
    String? initialValue,
    this.validators,
  })  : controller = TextEditingController(text: initialValue),
        super(initialValue);

  final TextEditingController controller;

  @override
  final List<XFieldValidator<String>>? validators;

  @override
  String get value => controller.text;

  @override
  void setValue(String? newValue) {
    controller.value = TextEditingValue(text: newValue ?? '');
  }

  @override
  void addListener(ValueChanged<String?> callback) {
    controller.addListener(() {
      callback.call(controller.text);
    });
  }

  @override
  bool hasChanged() {
    return value != (initialValue ?? '');
  }

  @override
  void removeListener(ValueChanged<String?> callback) {
    // TODO: implement removeListener
  }
}

class XRadioListField<T> extends XField<T> {
  XRadioListField({
    T? initialValue,
    this.validators,
  })  : _value = initialValue,
        super(initialValue);

  final List<ValueChanged<T?>> _listeners = [];

  @override
  List<XFieldValidator<T>>? validators;

  T? _value;

  @override
  T? get value => _value;

  @override
  void setValue(T? newValue) {
    _value = newValue;
    for (final listener in _listeners) {
      listener.call(value);
    }
  }

  @override
  void addListener(ValueChanged<T?> callback) {
    _listeners.add(callback);
  }

  @override
  bool hasChanged() {
    return initialValue != value;
  }

  @override
  void removeListener(ValueChanged<T?> callback) {
    _listeners.removeWhere((element) => element == callback);
  }
}

class XSelectListField<T> extends XField<List<T>> {
  XSelectListField({
    List<T>? initialValue,
    this.validators,
  })  : _value = initialValue,
        super(initialValue);

  final List<ValueChanged<List<T>?>> _listeners = [];

  @override
  List<XFieldValidator<List<T>>>? validators;

  List<T>? _value;

  @override
  List<T>? get value => _value;

  void addItem(T item) {
    setValue([
      if (value != null) ...value!,
      item,
    ]);
  }

  bool hasItem(T item) {
    return value?.contains(item) == true;
  }

  void removeItem(T item) {
    if (value != null) {
      final newValue = List.from(value!).cast<T>()..remove(item);
      setValue(newValue);
    }
  }

  @override
  void setValue(List<T>? newValue) {
    _value = newValue;
    for (final listener in _listeners) {
      listener.call(value);
    }
  }

  @override
  void addListener(ValueChanged<List<T>?> callback) {
    _listeners.add(callback);
  }

  @override
  bool hasChanged() {
    return initialValue != value;
  }

  @override
  void removeListener(ValueChanged<List<T>?> callback) {
    _listeners.removeWhere((element) => element == callback);
  }
}

class XDurationField extends XField<Duration> {
  XDurationField({
    Duration? initialValue,
    this.validators,
  })  : hoursController = TextEditingController(text: initialValue?.hours.toString()),
        minutesController = TextEditingController(text: initialValue?.minutes.toString()),
        secondsController = TextEditingController(text: initialValue?.seconds.toString()),
        super(initialValue) {
    hoursController.addListener(notifyListeners);
    minutesController.addListener(notifyListeners);
    secondsController.addListener(notifyListeners);
  }

  @override
  final List<XFieldValidator<Duration>>? validators;

  final List<ValueChanged<Duration?>> _listeners = [];

  final TextEditingController hoursController;
  final TextEditingController minutesController;
  final TextEditingController secondsController;

  notifyListeners() {
    for (final listener in _listeners) {
      listener.call(value);
    }
  }

  @override
  bool hasChanged() {
    return value != initialValue;
  }

  @override
  void addListener(ValueChanged<Duration?> callback) {
    _listeners.add(callback);
  }

  @override
  void removeListener(ValueChanged<Duration?> callback) {
    _listeners.removeWhere((element) => element == callback);
  }

  @override
  void setValue(Duration? newValue) {
    hoursController.text = newValue?.hours.toString() ?? '';
    minutesController.text = newValue?.minutes.toString() ?? '';
    secondsController.text = newValue?.seconds.toString() ?? '';
    notifyListeners();
  }

  @override
  Duration? get value => Duration(
      hours: int.tryParse(hoursController.text) ?? 0,
      seconds: int.tryParse(secondsController.text) ?? 0,
      minutes: int.tryParse(minutesController.text) ?? 0);
}

class XDistanceField extends XField<DistanceFieldValue> {
  XDistanceField({
    DistanceFieldValue? initialValue,
    this.validators,
  })  : valueController = TextEditingController(text: initialValue?.value?.toString()),
        unit = initialValue?.unit,
        super(initialValue) {
    valueController.addListener(() {
      notifyListeners();
    });
  }

  final List<ValueChanged<DistanceFieldValue?>> _listeners = [];
  final TextEditingController valueController;
  DistanceUnit? unit;

  @override
  final List<XFieldValidator<DistanceFieldValue>>? validators;

  notifyListeners() {
    for (final listener in _listeners) {
      listener.call(value);
    }
  }

  @override
  void setValue(DistanceFieldValue? newValue) {
    valueController.value = TextEditingValue(text: newValue?.value?.toString() ?? '');
    unit = newValue?.unit;
    notifyListeners();
  }

  @override
  bool hasChanged() {
    return value != initialValue;
  }

  @override
  void addListener(ValueChanged<DistanceFieldValue?> callback) {
    _listeners.add(callback);
  }

  @override
  void removeListener(ValueChanged<DistanceFieldValue?> callback) {
    _listeners.removeWhere((element) => element == callback);
  }

  @override
  DistanceFieldValue get value => DistanceFieldValue(value: double.tryParse(valueController.text), unit: unit);
}

class XLocationField extends XField<LatLng> {
  XLocationField({
    LatLng? initialValue,
    this.validators,
  })  : _value = initialValue,
        super(initialValue);

  final List<ValueChanged<LatLng?>> _listeners = [];

  @override
  List<XFieldValidator<LatLng>>? validators;

  LatLng? _value;

  @override
  LatLng? get value => _value;

  @override
  void setValue(LatLng? newValue) {
    _value = newValue;
    for (final listener in _listeners) {
      listener.call(value);
    }
  }

  @override
  void addListener(ValueChanged<LatLng?> callback) {
    _listeners.add(callback);
  }

  @override
  bool hasChanged() {
    return initialValue != value;
  }

  @override
  void removeListener(ValueChanged<LatLng?> callback) {
    _listeners.removeWhere((element) => element == callback);
  }
}

class XDateField extends XField<DateTime> {
  XDateField({
    DateTime? initialValue,
    this.validators,
  })  : _value = initialValue,
        super(initialValue);

  final List<ValueChanged<DateTime?>> _listeners = [];

  @override
  List<XFieldValidator<DateTime>>? validators;

  DateTime? _value;

  @override
  DateTime? get value => _value;

  @override
  void setValue(DateTime? newValue) {
    _value = newValue;
    for (final listener in _listeners) {
      listener.call(value);
    }
  }

  @override
  void addListener(ValueChanged<DateTime?> callback) {
    _listeners.add(callback);
  }

  @override
  bool hasChanged() {
    return initialValue != value;
  }

  @override
  void removeListener(ValueChanged<DateTime?> callback) {
    _listeners.removeWhere((element) => element == callback);
  }
}

enum EditionType { create, update }

class XFormStateHelper {
  XFormStateHelper({required this.fields}) {
    init();
  }

  final List<XField> fields;
  final Map<XField, List<XValidatorError>> errors = {};
  final Set<XField> changes = {};

  bool hasErrors = false;
  List<ValueChanged<bool>> hasErrorsCallbacks = [];

  bool hasChanges = false;
  List<ValueChanged<bool>> hasChangesCallbacks = [];

  void init() {
    for (final field in fields) {
      _handleValidation(field, field.value);
      _handleChanges(field, field.value);
      field.addListener((value) {
        _handleValidation(field, value);
        _handleChanges(field, value);
      });
    }
  }

  void _handleValidation(XField field, dynamic value) {
    final fieldErrors = field.errors();
    final previousFieldError = errors[field];
    final sameErrors = const ListEquality().equals(fieldErrors, previousFieldError);
    if (sameErrors == false) {
      if (fieldErrors == null || fieldErrors.isEmpty) {
        errors.remove(field);
      } else {
        errors[field] = fieldErrors;
      }
      notifyErrorsListeners();
    }
    final newHasErrors = errors.isNotEmpty;
    if (hasErrors != newHasErrors) {
      hasErrors = newHasErrors;
    }
  }

  void _handleChanges(XField field, dynamic value) {
    final fieldHasChanged = field.hasChanged();
    // final previousHasChanged = changes.contains(field);
    // if (fieldHasChanged != previousHasChanged) {
    if (fieldHasChanged == true) {
      changes.add(field);
    } else {
      changes.remove(field);
    }
    notifyChangesListeners();
    // }
    final newHasChanges = changes.isNotEmpty;
    if (hasChanges != newHasChanges) {
      hasChanges = newHasChanges;
    }
  }

  bool get canSave => hasChanges && !hasErrors;

  void listenChanges(ValueChanged<bool> callback) {
    hasChangesCallbacks.add(callback);
  }

  void removeChangesListener(ValueChanged<bool> callback) {
    hasChangesCallbacks.remove(callback);
  }

  void notifyChangesListeners() {
    for (final listener in hasChangesCallbacks) {
      listener.call(hasChanges);
    }
  }

  void listenErrors(ValueChanged<bool> callback) {
    hasErrorsCallbacks.add(callback);
  }

  void removeErrosListener(ValueChanged<bool> callback) {
    hasErrorsCallbacks.remove(callback);
  }

  void notifyErrorsListeners() {
    for (final listener in hasErrorsCallbacks) {
      listener.call(hasErrors);
    }
  }
}
