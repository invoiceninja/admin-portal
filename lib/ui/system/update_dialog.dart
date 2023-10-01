// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class UpdateDialog extends StatefulWidget {
  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

enum UpdateState {
  initial,
  loading,
  done,
}

class _UpdateDialogState extends State<UpdateDialog> {
  UpdateState updateState = UpdateState.initial;
  String? updateResponse;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final account = state.userCompany.account;
    const dockerCommand =
        'docker-compose down\ndocker-compose pull\ndocker-compose up';

    String? message = '';
    if (updateState == UpdateState.done) {
      message = updateResponse;
      if (message!.isEmpty) {
        message = localization!.appUpdated;
      } else if (message.contains('failed')) {
        message += '\n\n${localization!.updateFailHelp}\n\ngit checkout .';
      }
    }

    return AlertDialog(
      title: Text(account.isUpdateAvailable
          ? localization!.updateAvailable
          : localization!.forceUpdate),
      content: updateState == UpdateState.done
          ? SelectableText(message)
          : updateState == UpdateState.loading
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: LoadingIndicator(height: 50),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 400,
                      child: Text(
                        account.isUpdateAvailable
                            ? localization.aNewVersionIsAvailable
                            : localization.forceUpdateHelp,
                        maxLines: 2,
                      ),
                    ),
                    if (account.isUpdateAvailable) ...[
                      SizedBox(height: 20),
                      Text(
                          '• ${localization.installedVersion}: v${account.currentVersion}'),
                      SizedBox(height: 6),
                      Text(
                          '• ${localization.latestVersion}: v${account.latestVersion}'),
                    ],
                    if (account.isDocker) ...[
                      SizedBox(height: 20),
                      Text(localization.toUpdateRun + ':'),
                      SizedBox(height: 20),
                      ListTile(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: dockerCommand));
                          showToast(localization.copiedToClipboard
                              .replaceFirst(':value ', ''));
                        },
                        subtitle: Text(dockerCommand),
                        trailing: Icon(Icons.copy),
                      ),
                    ],
                  ],
                ),
      actions: <Widget>[
        if (updateState == UpdateState.initial) ...[
          TextButton(
            child: Text(localization.close.toUpperCase()),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          if (account.isUpdateAvailable)
            TextButton(
              child: Text(localization.releaseNotes.toUpperCase()),
              onPressed: () => launchUrl(Uri.parse(kReleaseNotesUrl)),
            )
          else
            TextButton(
              child: Text(localization.viewChanges.toUpperCase()),
              onPressed: () => launchUrl(Uri.parse(kGitHubDiffUrl.replaceFirst(
                  'VERSION', account.currentVersion))),
            ),
          if (!account.isDocker)
            TextButton(
              child: Text(localization.updateNow.toUpperCase()),
              onPressed: () {
                updateApp(context);
              },
            ),
        ] else if (updateState == UpdateState.done)
          TextButton(
            child: Text(localization.close.toUpperCase()),
            onPressed: () {
              Navigator.of(context).pop();
              store.dispatch(RefreshData());
            },
          ),
      ],
    );
  }

  void updateApp(BuildContext context) async {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    passwordCallback(
        alwaysRequire: true,
        context: context,
        callback: (password, idToken) {
          setState(() => updateState = UpdateState.loading);
          final credentials = state.credentials;
          final webClient = WebClient();
          final url = '${credentials.url}/self-update';
          webClient
              .post(
            url,
            credentials.token,
            password: password,
            idToken: idToken,
            rawResponse: true,
          )
              .then((dynamic response) {
            setState(() {
              updateState = UpdateState.done;
              updateResponse = jsonDecode(response.body)['message'];
            });

            if (updateResponse!.contains('failed')) {
              // do nothing
            } else {
              if (kIsWeb) {
                WebUtils.reloadBrowser();
              } else {
                store.dispatch(RefreshData(
                  clearData: true,
                  includeStatic: true,
                ));
              }
            }
          }).catchError((dynamic error) {
            var errorStr = '$error';

            if (errorStr.toLowerCase().contains('unexpected end of')) {
              errorStr +=
                  '\n\nIt may help to increase the server PHP memory limit';
            }

            showErrorDialog(message: errorStr);
            setState(() => updateState = UpdateState.initial);
          });
        });
  }
}
