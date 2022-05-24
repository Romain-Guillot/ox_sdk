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

  late XFormStateHelper helper;

  EditionType get editionType {
    return initialValue == null 
      ? EditionType.create
      : EditionType.update;
  } 

  bool hasChanges() => helper.hasChanges;

  bool hasErrors() => helper.hasErrors;

  bool canSave() => helper.canSave;

  T? build();
  
}