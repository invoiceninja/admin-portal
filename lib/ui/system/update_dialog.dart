import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
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

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return AlertDialog(
      title: Text(localization.updateAvailable),
      content: updateState == UpdateState.done
          ? Text(localization.appUpdated)
          : updateState == UpdateState.loading
              ? LoadingIndicator(height: 50)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(localization.aNewVersionIsAvailable),
                    SizedBox(height: 20),
                    Text('• ${localization.currentVersion}: v$kAppVersion'),
                    //Text('• ${localization.latestVersion}: v???'),
                  ],
                ),
      actions: <Widget>[
        if (updateState == UpdateState.initial) ...[
          FlatButton(
            child: Text(localization.cancel.toUpperCase()),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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
            },
          ),
      ],
    );
  }

  void updateApp(BuildContext context) async {
    final state = StoreProvider.of<AppState>(context).state;
    passwordCallback(
        context: context,
        callback: (password) {
          setState(() => updateState = UpdateState.loading);
          final credentials = state.credentials;
          final webClient = WebClient();
          const url = '/self-update';
          webClient
              .post(url, credentials.token, password: password)
              .then((dynamic response) {
            if (response['message'] == true) {
              setState(() => updateState = UpdateState.done);
              if (kIsWeb) {
                webReload();
              }
            } else {
              setState(() => updateState = UpdateState.initial);
              showErrorDialog(context: context, message: '$response');
            }
          }).catchError((dynamic error) {
            showErrorDialog(context: context, message: '$error');
            setState(() => updateState = UpdateState.initial);
          });
        });
  }
}
