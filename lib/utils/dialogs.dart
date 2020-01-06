import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

void showErrorDialog({BuildContext context, String message}) {
  showDialog<ErrorDialog>(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(message);
      });
}

void confirmCallback({BuildContext context, VoidCallback callback}) {
  final localization = AppLocalization.of(context);

  showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      semanticLabel: localization.areYouSure,
      title: Text(localization.areYouSure),
      actions: <Widget>[
        FlatButton(
            child: Text(localization.cancel.toUpperCase()),
            onPressed: () {
              Navigator.pop(context);
            }),
        FlatButton(
            child: Text(localization.ok.toUpperCase()),
            onPressed: () {
              Navigator.pop(context);
              callback();
            })
      ],
    ),
  );
}

void passwordCallback({BuildContext context, Function(String) callback}) {
  showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) {
      return PasswordConfirmation(
        callback: callback,
      );
    },
  );
}

class PasswordConfirmation extends StatefulWidget {
  const PasswordConfirmation({@required this.callback});

  final Function(String) callback;

  @override
  _PasswordConfirmationState createState() => _PasswordConfirmationState();
}

class _PasswordConfirmationState extends State<PasswordConfirmation> {
  String _password;

  void _submit() {
    widget.callback(_password);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Dialog(
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: TextField(
              onChanged: (value) => _password = value,
              obscureText: true,
              onSubmitted: (value) => _submit(),
            )),
            RaisedButton(
              child: Text(localization.save),
              onPressed: () => _submit(),
            )
          ],
        )
      ]),
    );
  }
}
