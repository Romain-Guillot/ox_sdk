import 'package:flutter/material.dart';
import 'package:ox_sdk/src/xframework/form/form.dart';

abstract class XFormChangeNotifier<T> extends ChangeNotifier {
  XFormChangeNotifier(this.initialValue);

  init() {
    helper.listenChanges((value) {
      notifyListeners();
    });

    helper.listenErrors((value) {
      notifyListeners();
    });
  }

  T? initialValue;

  XFormStateHelper get helper;

  EditionType get editionType {
    return initialValue == null ? EditionType.create : EditionType.update;
  }

  bool get hasChanges => helper.hasChanges;

  bool get hasErrors => helper.hasErrors;

  bool get canSave => helper.canSave;

  T? build();
}
