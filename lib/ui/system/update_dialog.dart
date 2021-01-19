import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/loading_indicator.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';
import 'package:url_launcher/url_launcher.dart';

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
  String updateResponse;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final account = state.userCompany.account;

    return AlertDialog(
      title: Text(account.isUpdateAvailable
          ? localization.updateAvailable
          : localization.forceUpdate),
      content: updateState == UpdateState.done
          ? Text('${localization.appUpdated}\n\n$updateResponse')
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
                    SizedBox(height: 20),
                    Text(
                        '• ${localization.currentVersion}: v${account.currentVersion}'),
                    SizedBox(height: 6),
                    Text(
                        '• ${localization.latestVersion}: v${account.latestVersion}'),
                  ],
                ),
      actions: <Widget>[
        if (updateState == UpdateState.initial) ...[
          FlatButton(
            child: Text(localization.close.toUpperCase()),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          if (!account.isUpdateAvailable)
            FlatButton(
              child: Text(localization.viewChanges.toUpperCase()),
              onPressed: () => launch(kGitHubDiffUrl.replaceFirst(
                  'VERSION', account.currentVersion)),
            ),
          if (!account.isDocker)
            FlatButton(
              child: Text(localization.updateNow.toUpperCase()),
              onPressed: () {
                updateApp(context);
              },
            ),
        ] else if (updateState == UpdateState.done)
          FlatButton(
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
        callback: (password) {
          setState(() => updateState = UpdateState.loading);
          final credentials = state.credentials;
          final webClient = WebClient();
          final url = '${credentials.url}/self-update';
          webClient
              .post(url, credentials.token,
                  password: password, rawResponse: true)
              .then((dynamic response) {
            setState(() {
              updateState = UpdateState.done;
              updateResponse = response.body;
            });
            if (kIsWeb) {
              WebUtils.reloadBrowser();
            } else {
              store.dispatch(RefreshData(
                clearData: true,
                includeStatic: true,
              ));
            }
          }).catchError((dynamic error) {
            showErrorDialog(context: context, message: '$error');
            setState(() => updateState = UpdateState.initial);
          });
        });
  }
}
