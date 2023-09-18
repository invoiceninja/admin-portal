// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:html2md/html2md.dart' as html2md;

// Project imports:
import 'package:invoiceninja_flutter/.env.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(this.error, {this.clearErrorOnDismiss = false});

  final Object? error;
  final bool clearErrorOnDismiss;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;
    final store = StoreProvider.of<AppState>(context);
    String errorStr = '$error'.trim();

    if (errorStr.startsWith('<')) {
      errorStr = html2md.convert(errorStr);
    }

    if (error is Error) {
      errorStr += '\n\n' + (error as Error).stackTrace.toString();
    }

    return PointerInterceptor(
      child: AlertDialog(
        title: Text(localization.error),
        content:
            error != null ? SelectableText(errorStr.toString()) : SizedBox(),
        actions: [
          if (clearErrorOnDismiss && !Config.DEMO_MODE)
            TextButton(
                child: Text(localization.logout.toUpperCase()),
                onPressed: () {
                  confirmCallback(
                      context: context,
                      callback: (_) {
                        store.dispatch(UserLogout());
                      });
                }),
          TextButton(
              child: Text(localization.copy.toUpperCase()),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: errorStr));
              }),
          TextButton(
              autofocus: true,
              child: Text(localization.dismiss.toUpperCase()),
              onPressed: () {
                if (clearErrorOnDismiss) {
                  store.dispatch(ClearLastError());
                }
                Navigator.of(context).pop();
              }),
        ],
      ),
    );
  }
}
