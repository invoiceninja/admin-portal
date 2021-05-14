import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/ui/app/forms/save_cancel_buttons.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/oauth.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

void showErrorDialog({
  @required BuildContext context,
  String message,
  bool clearErrorOnDismiss = false,
}) {
  showDialog<ErrorDialog>(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(message, clearErrorOnDismiss: clearErrorOnDismiss);
      });
}

void showMessageDialog({
  @required BuildContext context,
  @required String message,
  List<TextButton> secondaryActions,
}) {
  showDialog<MessageDialog>(
      context: context,
      builder: (BuildContext context) {
        return MessageDialog(
          message,
          secondaryActions: secondaryActions,
        );
      });
}

void confirmCallback({
  @required BuildContext context,
  @required VoidCallback callback,
  String message,
  String typeToConfirm,
  bool skip = false,
}) {
  if (skip) {
    callback();
    return;
  }

  final localization = AppLocalization.of(context);
  final title = message == null ? localization.areYouSure : message;
  final content = message == null ? null : localization.areYouSure;

  showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) {
      String _typed = '';

      void _onPressed() {
        if (typeToConfirm == null ||
            typeToConfirm.toLowerCase() == _typed.toLowerCase()) {
          Navigator.pop(context);
          callback();
        }
      }

      return AlertDialog(
        semanticLabel: localization.areYouSure,
        title: Text(title),
        content: typeToConfirm != null
            ? Row(
                children: [
                  Flexible(
                    child: Text(localization.pleaseTypeToConfirm
                            .replaceFirst(':value', typeToConfirm) +
                        ':'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DecoratedFormField(
                      autofocus: true,
                      onChanged: (value) => _typed = value,
                      hint: typeToConfirm,
                      onSavePressed: (context) => _onPressed(),
                    ),
                  ),
                ],
              )
            : content == null
                ? null
                : Text(content),
        actions: <Widget>[
          TextButton(
              child: Text(localization.cancel.toUpperCase()),
              onPressed: () {
                Navigator.pop(context);
              }),
          TextButton(
            autofocus: true,
            child: Text(localization.ok.toUpperCase()),
            onPressed: () => _onPressed(),
          )
        ],
      );
    },
  );
}

void passwordCallback({
  BuildContext context,
  Function(String, String) callback,
  bool alwaysRequire = false,
  bool skipOAuth = false,
}) {
  final state = StoreProvider.of<AppState>(context).state;
  if (state.authState.hasRecentlyEnteredPassword && !alwaysRequire) {
    callback(null, null);
    return;
  } else if (!state.user.hasPassword && skipOAuth) {
    callback(null, null);
    return;
  }

  if (state.user.oauthProvider.isEmpty || skipOAuth) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PasswordConfirmation(
          callback: callback,
        );
      },
    );
    return;
  }

  try {
    GoogleOAuth.signIn((idToken, accessToken) {
      if (!state.company.oauthPasswordRequired || !state.user.hasPassword) {
        callback(null, idToken);
      } else {
        showDialog<AlertDialog>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return PasswordConfirmation(
              callback: callback,
              idToken: idToken,
            );
          },
        );
      }
    }, isSilent: true);
  } catch (error) {
    showErrorDialog(context: context, message: '$error');
  }
}

class PasswordConfirmation extends StatefulWidget {
  const PasswordConfirmation({@required this.callback, this.idToken});

  final Function(String, String) callback;
  final String idToken;

  @override
  _PasswordConfirmationState createState() => _PasswordConfirmationState();
}

class _PasswordConfirmationState extends State<PasswordConfirmation> {
  String _password;
  bool _isPasswordObscured = true;

  void _submit() {
    if ((_password ?? '').isEmpty) {
      return;
    }
    Navigator.pop(context);
    widget.callback(_password, widget.idToken);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AlertDialog(
      title: Text(localization.verifyPassword),
      content: TextField(
        autofocus: true,
        onChanged: (value) => _password = value,
        obscureText: _isPasswordObscured,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: localization.password,
          suffixIcon: IconButton(
            alignment: Alignment.bottomCenter,
            icon: Icon(
              _isPasswordObscured ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
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
          isHeader: false,
          saveLabel: localization.submit.toUpperCase(),
          onSavePressed: (context) => _submit(),
          cancelLabel: localization.cancel.toUpperCase(),
          onCancelPressed: (context) {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

void fieldCallback({
  BuildContext context,
  String title,
  String field,
  Function(String) callback,
  int maxLength,
  List<TextButton> secondaryActions,
}) {
  showDialog<AlertDialog>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return FieldConfirmation(
        callback: callback,
        field: field,
        title: title,
        maxLength: maxLength,
        secondaryActions: secondaryActions,
      );
    },
  );
}

class FieldConfirmation extends StatefulWidget {
  const FieldConfirmation({
    @required this.callback,
    @required this.title,
    @required this.field,
    this.maxLength,
    this.secondaryActions,
  });

  final Function(String) callback;
  final String title;
  final String field;
  final int maxLength;
  final List<TextButton> secondaryActions;

  @override
  _FieldConfirmationState createState() => _FieldConfirmationState();
}

class _FieldConfirmationState extends State<FieldConfirmation> {
  String _field;

  void _submit() {
    if ((_field ?? '').isEmpty) {
      return;
    }
    Navigator.pop(context);
    widget.callback(_field);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        autofocus: true,
        onChanged: (value) => _field = value,
        maxLength: widget.maxLength,
        maxLengthEnforced: widget.maxLength != null,
        buildCounter: (_, {currentLength, maxLength, isFocused}) => null,
        decoration: InputDecoration(
          labelText: widget.field,
        ),
        onSubmitted: (value) => _submit(),
      ),
      actions: <Widget>[
        ...widget.secondaryActions ?? [],
        SizedBox(width: 6),
        SaveCancelButtons(
          isHeader: false,
          saveLabel: localization.save.toUpperCase(),
          onSavePressed: (context) => _submit(),
          cancelLabel: localization.cancel.toUpperCase(),
          onCancelPressed: (context) {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

void cloneToDialog({
  @required BuildContext context,
  @required InvoiceEntity invoice,
}) {
  final localization = AppLocalization.of(context);
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final userCompany = state.userCompany;

  showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localization.cloneTo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (userCompany.canCreate(EntityType.invoice))
                ListTile(
                  leading: Icon(getEntityIcon(EntityType.invoice)),
                  title: Text(localization.invoice),
                  onTap: () {
                    handleEntityAction(context.getAppContext(), invoice,
                        EntityAction.cloneToInvoice);
                    Navigator.of(context).pop();
                  },
                ),
              if (userCompany.canCreate(EntityType.quote))
                ListTile(
                  leading: Icon(getEntityIcon(EntityType.quote)),
                  title: Text(localization.quote),
                  onTap: () {
                    handleEntityAction(context.getAppContext(), invoice,
                        EntityAction.cloneToQuote);
                    Navigator.of(context).pop();
                  },
                ),
              if (userCompany.canCreate(EntityType.credit))
                ListTile(
                  leading: Icon(getEntityIcon(EntityType.credit)),
                  title: Text(localization.credit),
                  onTap: () {
                    handleEntityAction(context.getAppContext(), invoice,
                        EntityAction.cloneToCredit);
                    Navigator.of(context).pop();
                  },
                ),
              if (userCompany.canCreate(EntityType.recurringInvoice))
                ListTile(
                  leading: Icon(getEntityIcon(EntityType.recurringInvoice)),
                  title: Text(localization.recurringInvoice),
                  onTap: () {
                    handleEntityAction(context.getAppContext(), invoice,
                        EntityAction.cloneToRecurring);
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
          actions: [
            TextButton(
              child: Text(localization.close.toUpperCase()),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      });
}
