// Flutter imports:
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/main_app.dart';
import 'package:invoiceninja_flutter/redux/task/task_actions.dart';
import 'package:invoiceninja_flutter/redux/task_status/task_status_selectors.dart';
import 'package:invoiceninja_flutter/ui/app/forms/design_picker.dart';
import 'package:invoiceninja_flutter/utils/files.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/models.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/alert_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/error_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/dialogs/loading_dialog.dart';
import 'package:invoiceninja_flutter/ui/app/forms/decorated_form_field.dart';
import 'package:invoiceninja_flutter/utils/completers.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/oauth.dart';

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';
import 'package:printing/printing.dart';

void showRefreshDataDialog(
    {required BuildContext context, bool includeStatic = false}) async {
  final store = StoreProvider.of<AppState>(context);
  store.dispatch(RefreshData(
    completer: snackBarCompleter<Null>(
        AppLocalization.of(context)!.refreshComplete,
        shouldPop: true),
    clearData: true,
    includeStatic: includeStatic,
  ));

  await showDialog<AlertDialog>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => SimpleDialog(
            children: <Widget>[LoadingDialog()],
          ));

  AppBuilder.of(navigatorKey.currentContext!)!.rebuild();
}

void showErrorDialog({
  String? message,
  bool clearErrorOnDismiss = false,
}) {
  showDialog<ErrorDialog>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        return ErrorDialog(message, clearErrorOnDismiss: clearErrorOnDismiss);
      });
}

void showMessageDialog({
  required String? message,
  List<TextButton>? secondaryActions,
  Function? onDismiss,
}) {
  final context = navigatorKey.currentContext!;
  showDialog<MessageDialog>(
      context: context,
      builder: (BuildContext context) {
        return MessageDialog(
          message,
          secondaryActions: secondaryActions,
          onDismiss: onDismiss,
        );
      });
}

void confirmCallback({
  required BuildContext? context,
  required Function(String?) callback,
  String? message,
  String? typeToConfirm,
  bool askForReason = false,
  bool skip = false,
}) {
  if (skip) {
    callback(null);
    return;
  }

  final localization = AppLocalization.of(context!);
  final title = message == null ? localization!.areYouSure : message;
  final content = message == null ? null : localization!.areYouSure;

  showDialog<AlertDialog>(
    context: context,
    builder: (BuildContext context) {
      String _typed = '';
      String _reason = '';

      void _onPressed() {
        if (typeToConfirm == null ||
            typeToConfirm.toLowerCase() == _typed.toLowerCase()) {
          Navigator.pop(context);
          callback(_reason);
        } else {
          showMessageDialog(
              message: localization!.pleaseTypeToConfirm
                  .replaceFirst(':value', typeToConfirm));
        }
      }

      return PointerInterceptor(
        child: AlertDialog(
          semanticLabel: localization!.areYouSure,
          title: typeToConfirm != null ? null : Text(title),
          content: typeToConfirm != null
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 8),
                    Flexible(
                      child: Text(localization.pleaseTypeToConfirm
                              .replaceFirst(':value', typeToConfirm) +
                          ':'),
                    ),
                    DecoratedFormField(
                      autofocus: true,
                      onChanged: (value) => _typed = value,
                      hint: typeToConfirm,
                      onSavePressed: (context) => _onPressed(),
                      keyboardType: TextInputType.text,
                    ),
                    if (askForReason) ...[
                      SizedBox(height: 30),
                      Flexible(child: Text(localization.whyAreYouLeaving)),
                      DecoratedFormField(
                        onChanged: (value) => _reason = value,
                        minLines: 4,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                      ),
                    ],
                    SizedBox(height: 30),
                    Flexible(
                        child: Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )),
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
              child: Text(localization.ok.toUpperCase()),
              onPressed: () => _onPressed(),
              autofocus: typeToConfirm == null,
            )
          ],
        ),
      );
    },
  );
}

void passwordCallback({
  required BuildContext context,
  required Function(String?, String?) callback,
  bool alwaysRequire = false,
  bool skipOAuth = false,
}) {
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final localization = AppLocalization.of(context);
  final user = state.user;

  print(
      '## Confirm password: $alwaysRequire, ${user.hasPassword}, ${state.hasRecentlyEnteredPassword}, ${user.oauthProvider}, ${state.company.oauthPasswordRequired}');

  if (alwaysRequire && !user.hasPassword) {
    showMessageDialog(
        message: localization!.pleaseSetAPassword,
        secondaryActions: [
          TextButton(
              onPressed: () {
                store.dispatch(ViewSettings(section: kSettingsUserDetails));
                Navigator.of(context).pop();
              },
              child: Text(localization.setPassword.toUpperCase()))
        ]);
    print('## 1');
    return;
  }

  if (state.hasRecentlyEnteredPassword && !alwaysRequire) {
    callback(null, null);
    print('## 2');
    return;
  }

  if (user.oauthProvider.isEmpty ||
      skipOAuth ||
      user.isConnectedToApple ||
      //(user.isConnectedToApple && !supportsAppleOAuth()) ||
      (user.isConnectedToGoogle && !supportsGoogleOAuth()) ||
      (user.isConnectedToMicrosoft && !supportsMicrosoftOAuth())) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        print('## 3');
        return PasswordConfirmation(
          callback: callback,
        );
      },
    );
    return;
  }

  try {
    if (user.isConnectedToGoogle) {
      GoogleOAuth.signIn((idToken, accessToken) {
        if ((!alwaysRequire && !state.company.oauthPasswordRequired) ||
            !user.hasPassword) {
          print('## 4');
          callback(null, idToken);
        } else {
          print('## 5');
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
    } else if (user.isConnectedToMicrosoft) {
      WebUtils.microsoftLogin((idToken, accessToken) {
        if ((!alwaysRequire && !state.company.oauthPasswordRequired) ||
            !user.hasPassword) {
          print('## 6');
          callback(null, idToken);
        } else {
          print('## 7');
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
      }, (dynamic error) {
        showErrorDialog(message: error);
      });
    }
  } catch (error) {
    showErrorDialog(message: '$error');
  }

  print('## 8');
}

class PasswordConfirmation extends StatefulWidget {
  const PasswordConfirmation({required this.callback, this.idToken = ''});

  final Function(String, String) callback;
  final String idToken;

  @override
  _PasswordConfirmationState createState() => _PasswordConfirmationState();
}

class _PasswordConfirmationState extends State<PasswordConfirmation> {
  String? _password;
  bool _isPasswordObscured = true;

  void _submit() {
    final password = (_password ?? '').trim();
    if (password.isEmpty) {
      return;
    }
    Navigator.pop(context);
    widget.callback(password, widget.idToken);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

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
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localization.cancel.toUpperCase())),
        TextButton(
            onPressed: () => _submit(),
            child: Text(localization.submit.toUpperCase())),
      ],
    );
  }
}

void fieldCallback({
  required BuildContext context,
  String? title,
  String? field,
  String value = '',
  Function(String)? callback,
  int? maxLength,
  List<TextButton>? secondaryActions,
}) {
  showDialog<AlertDialog>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return FieldConfirmation(
        callback: callback,
        field: field,
        title: title,
        value: value,
        maxLength: maxLength,
        secondaryActions: secondaryActions,
      );
    },
  );
}

class FieldConfirmation extends StatefulWidget {
  const FieldConfirmation({
    required this.callback,
    required this.title,
    required this.field,
    this.value = '',
    this.maxLength,
    this.secondaryActions,
  });

  final Function(String)? callback;
  final String? title;
  final String? field;
  final String value;
  final int? maxLength;
  final List<TextButton>? secondaryActions;

  @override
  _FieldConfirmationState createState() => _FieldConfirmationState();
}

class _FieldConfirmationState extends State<FieldConfirmation> {
  String? _field;

  void _submit() {
    final value = (_field ?? '').trim();

    if (value.isEmpty) {
      return;
    }

    Navigator.pop(context);
    widget.callback!(value);
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return AlertDialog(
      title: Text(widget.title!),
      content: TextFormField(
        initialValue: widget.value,
        autofocus: true,
        onChanged: (value) => _field = value,
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLength != null
            ? MaxLengthEnforcement.enforced
            : MaxLengthEnforcement.none,
        //buildCounter: (_, {currentLength, maxLength, isFocused}) => null,
        decoration: InputDecoration(
          labelText: widget.field,
        ),
        onFieldSubmitted: (value) => _submit(),
      ),
      actions: <Widget>[
        ...widget.secondaryActions ?? [],
        SizedBox(width: 6),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localization.cancel.toUpperCase())),
        TextButton(
            onPressed: () => _submit(),
            child: Text(localization.submit.toUpperCase())),
      ],
    );
  }
}

void cloneToDialog({
  required InvoiceEntity invoice,
}) {
  final context = navigatorKey.currentContext!;
  final localization = AppLocalization.of(context);
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final userCompany = state.userCompany;

  showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localization!.cloneTo),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (userCompany.canCreate(EntityType.invoice))
                ListTile(
                  leading: Icon(getEntityIcon(EntityType.invoice)),
                  title: Text(localization.invoice),
                  onTap: () {
                    Navigator.of(context).pop();
                    handleEntityAction(invoice, EntityAction.cloneToInvoice);
                  },
                ),
              if (userCompany.canCreate(EntityType.quote))
                ListTile(
                  leading: Icon(getEntityIcon(EntityType.quote)),
                  title: Text(localization.quote),
                  onTap: () {
                    Navigator.of(context).pop();
                    handleEntityAction(invoice, EntityAction.cloneToQuote);
                  },
                ),
              if (userCompany.canCreate(EntityType.credit))
                ListTile(
                  leading: Icon(getEntityIcon(EntityType.credit)),
                  title: Text(localization.credit),
                  onTap: () {
                    Navigator.of(context).pop();
                    handleEntityAction(invoice, EntityAction.cloneToCredit);
                  },
                ),
              if (userCompany.canCreate(EntityType.recurringInvoice))
                ListTile(
                  leading: Icon(getEntityIcon(EntityType.recurringInvoice)),
                  title: Text(localization.recurringInvoice),
                  onTap: () {
                    Navigator.of(context).pop();
                    handleEntityAction(invoice, EntityAction.cloneToRecurring);
                  },
                ),
              if (userCompany.canCreate(EntityType.purchaseOrder))
                ListTile(
                  leading: Icon(getEntityIcon(EntityType.purchaseOrder)),
                  title: Text(localization.purchaseOrder),
                  onTap: () {
                    Navigator.of(context).pop();
                    handleEntityAction(
                        invoice, EntityAction.cloneToPurchaseOrder);
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

void changeTaskStatusDialog({
  required BuildContext context,
  required TaskEntity task,
}) {
  final localization = AppLocalization.of(context);
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;
  final statusIds = memoizedSortedActiveTaskStatusIds(
          state.taskStatusState.list, state.taskStatusState.map)
      .where((statusId) => statusId != task.statusId)
      .toList();

  showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localization!.changeStatus),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: statusIds.map((statusId) {
              final status = state.taskStatusState.get(statusId);
              return ListTile(
                title: Text(status.name),
                leading: Icon(Icons.check_circle),
                onTap: () {
                  store.dispatch(SaveTaskRequest(
                    task: task.rebuild((b) => b..statusId = statusId),
                    completer: snackBarCompleter<TaskEntity>(
                      localization.changedStatus,
                    ),
                  ));
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
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

void addToInvoiceDialog({
  required BuildContext context,
  required String? clientId,
  required List<InvoiceItemEntity> items,
}) {
  final localization = AppLocalization.of(context);
  final store = StoreProvider.of<AppState>(context);
  final state = store.state;

  final invoices = state.invoiceState.map.values.where((invoice) {
    if (clientId != invoice.clientId) {
      return false;
    }

    return invoice.isActive && !invoice.isPaid;
  });

  if (invoices.isEmpty) {
    showMessageDialog(message: localization!.noInvoicesFound);
    return;
  }

  showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(localization!.addToInvoice),
          children: invoices.map((invoice) {
            return SimpleDialogOption(
              child: Row(children: [
                Expanded(child: Text(invoice.number)),
                Text(
                  formatNumber(invoice.amount, context,
                      clientId: invoice.clientId)!,
                ),
              ]),
              onPressed: () {
                Navigator.of(context).pop();
                editEntity(
                    entity: invoice.rebuild(
                  (b) => b..lineItems.addAll(items),
                ));
              },
            );
          }).toList(),
        );
      });
}

class RunTemplateDialog extends StatefulWidget {
  const RunTemplateDialog({
    super.key,
    required this.entityType,
    required this.entities,
  });

  final EntityType entityType;
  final List<BaseEntity> entities;

  @override
  State<RunTemplateDialog> createState() => _RunTemplateDialogState();
}

class _RunTemplateDialogState extends State<RunTemplateDialog> {
  String _designId = '';
  bool _sendEmail = false;
  bool _isLoading = false;
  Uint8List? _data;

  Future<bool> loadTemplate(String jobHash) async {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final credentials = state.credentials;
    final url = '${credentials.url}/templates/preview/$jobHash';

    while (_data == null && mounted) {
      await Future.delayed(Duration(seconds: 3));

      try {
        final response =
            await WebClient().post(url, credentials.token, rawResponse: true);
        _data = response.bodyBytes;
      } catch (error) {
        print('## CATCH ERROR: $error');
      }
    }

    return _data != null;
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context)!;

    return AlertDialog(
      title: Text(localization.runTemplate),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text((_isLoading ? localization.cancel : localization.close)
              .toUpperCase()),
        ),
        if (_data != null) ...[
          /*
          TextButton(
            onPressed: () {
              setState(() {
                _data = null;
                _designId = '';
              });
            },
            child: Text(
              localization.reset.toUpperCase(),
            ),
          ),
          */
          TextButton(
            child: Text(localization.download.toUpperCase()),
            onPressed: () {
              final design = state.designState.map[_designId]!;
              saveDownloadedFile(_data!, '${design.name}.pdf');
            },
          ),
        ] else if (!_isLoading)
          TextButton(
            onPressed: _designId.isEmpty
                ? null
                : () {
                    final credentials = state.credentials;
                    final url =
                        '${credentials.url}/${widget.entityType.pluralApiValue}/bulk';
                    final data = {
                      'ids':
                          widget.entities.map((entity) => entity.id).toList(),
                      'entity': widget.entityType.apiValue,
                      'template_id': _designId,
                      'send_email': _sendEmail,
                      'action': EntityAction.runTemplate.toApiParam(),
                    };

                    print('## DATA: $data');

                    setState(() => _isLoading = true);

                    WebClient()
                        .post(url, credentials.token, data: jsonEncode(data))
                        .then((response) async {
                      print('## RESPONSE: $response');

                      if (_sendEmail) {
                        setState(() => _isLoading = false);
                        Navigator.of(navigatorKey.currentContext!).pop();
                        showToast(localization.exportedData);
                      } else {
                        final jobHash = response['message'];
                        await loadTemplate(jobHash);
                        setState(() => _isLoading = false);
                      }
                    }).catchError((error) {
                      print('## ERROR: $error');
                      setState(() => _isLoading = false);
                    });
                  },
            child: Text(localization.start.toUpperCase()),
          ),
      ],
      content: _data != null
          ? SizedBox(
              width: 600,
              child: PdfPreview(
                build: (format) => _data!,
                canChangeOrientation: false,
                canChangePageFormat: false,
                allowPrinting: false,
                allowSharing: false,
                canDebug: false,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    localization.lookup(widget.entities.length == 1
                        ? widget.entityType.snakeCase
                        : widget.entityType.plural +
                            ' (${widget.entities.length})'),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 8),
                  ...widget.entities
                      .map((entity) => Text(entity.listDisplayName))
                      .toList(),
                  if (_isLoading) ...[
                    SizedBox(height: 32),
                    LinearProgressIndicator()
                  ] else ...[
                    SizedBox(height: 16),
                    DesignPicker(
                      autofocus: true,
                      entityType: widget.entityType,
                      initialValue: _designId,
                      onSelected: (design) {
                        setState(() {
                          _designId = design?.id ?? '';
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    SwitchListTile(
                      value: _sendEmail,
                      title: Text(
                        localization.sendEmail,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _sendEmail = value;
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}
