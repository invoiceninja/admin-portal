import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/snackbar_row.dart';

/*
Completer<Null> refreshCompleter(BuildContext context) {
  final Completer<Null> completer = Completer<Null>();

  completer.future.then((_) {
    Scaffold.of(context).showSnackBar(SnackBar(
        content: SnackBarRow(
          message: AppLocalization.of(context).refreshComplete,
        )));
  }).catchError((Object error) {
    showDialog<ErrorDialog>(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(error);
        });
  });

  return completer;
}
*/

Completer<Null> snackBarCompleter(BuildContext context, String message,
    {bool shouldPop = false}) {
  final Completer<Null> completer = Completer<Null>();

  completer.future.then((_) {
    if (shouldPop) {
      Navigator.of(context).pop();
    }
    Scaffold.of(context).showSnackBar(SnackBar(
        content: SnackBarRow(
      message: message,
    )));
  }).catchError((Object error) {
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
