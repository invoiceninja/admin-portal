import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';

Completer<T> snackBarCompleter<T>(BuildContext context, String message,
    {bool shouldPop = false}) {
  final Completer<T> completer = Completer<T>();
  final navigator = Navigator.of(context);

  completer.future.then((_) {
    if (shouldPop && navigator.canPop()) {
      navigator.pop();
    }
    showToast(message);
  }).catchError((Object error) {
    if (shouldPop && navigator.canPop()) {
      navigator.pop();
    }
    showDialog<ErrorDialog>(
        context: navigatorKey.currentContext,
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
        context: navigatorKey.currentContext,
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
        context: navigatorKey.currentContext,
        builder: (BuildContext context) {
          return ErrorDialog(error);
        });
  });

  return completer;
}

// https://stackoverflow.com/a/55119208/497368
class Debouncer {
  Debouncer({this.milliseconds = kMillisecondsToDebounceUpdate});

  final int milliseconds;
  static VoidCallback action;
  static Timer timer;

  void run(VoidCallback action) {
    if (milliseconds == null) {
      action();
      return;
    }

    if (timer == null) {
      action();
    } else {
      timer.cancel();
      Debouncer.action = action;
    }

    timer = Timer(Duration(milliseconds: milliseconds), () {
      if (action != null) {
        action();
      }
      Debouncer.action = null;
      Debouncer.timer = null;
    });
  }

  static void complete() {
    if (action != null) {
      action();
    }
  }

  static void runOnComplete(Function callback) {
    complete();
    callback();
  }
}
