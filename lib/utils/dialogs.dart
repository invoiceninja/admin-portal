import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
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
    barrierDismissible: false,
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
  bool _isPasswordObscured = true;

  void _submit() {
    widget.callback(_password);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AlertDialog(
      title: Text(localization.verifyPassword),
      content: TextField(
        onChanged: (value) => _password = value,
        obscureText: _isPasswordObscured,
        decoration: InputDecoration(
          labelText: localization.password,
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordObscured ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                _isPasswordObscured = !_isPasswordObscured;
              });
            },
          ),
        ),
        onSubmitted: (value) => _submit(),
      ),
      actions: <Widget>[
        SaveCancelButtons(
          saveLabel: localization.save.toUpperCase(),
          onSavePressed: (context) {
            if ((_password ?? '').isEmpty) {
              return;
            }
            Navigator.pop(context);
            widget.callback(_password);
          },
          cancelLabel: localization.cancel.toUpperCase(),
          onCancelPressed: (context) {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

