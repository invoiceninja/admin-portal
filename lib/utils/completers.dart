import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';

Completer<T> snackBarCompleter<T>(BuildContext context, String message,
    {bool shouldPop = false}) {
  final Completer<T> completer = Completer<T>();

  completer.future.then((_) {
    if (shouldPop && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    showToast(message);
  }).catchError((Object error) {
    if (shouldPop && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    showDialog<ErrorDialog>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(error);
        });
  });

  return completer;
}

Completer<Null> popCompleter(BuildContext context, dynamic result) {
  final Completer<Null> completer = Completer<Null>();

  completer.future.then((_) {
    Navigator.of(context).pop<dynamic>(result);
  }).catchError((Object error) {
    showDialog<ErrorDialog>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(error);
        });
  });

  return completer;
}

Completer<Null> errorCompleter(BuildContext context) {
  final Completer<Null> completer = Completer<Null>();

  completer.future.catchError((Object error) {
    showDialog<ErrorDialog>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(error);
        });
  });

  return completer;
}

// https://stackoverflow.com/a/55119208/497368
class Debouncer {
  Debouncer({this.milliseconds});

  static bool isDebouncing = false;
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  void run(VoidCallback action) {
    if (milliseconds == null) {
      action();
      return;
    }

    if (_timer != null) {
      _timer.cancel();
    }

    Debouncer.isDebouncing = true;

    _timer = Timer(Duration(milliseconds: milliseconds), () {
      Debouncer.isDebouncing = false;
      action();
    });
  }
}
