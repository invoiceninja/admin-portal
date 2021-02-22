import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class SessionTimeout extends StatefulWidget {
  const SessionTimeout({this.child});
  final Widget child;

  @override
  _SessionTimeoutState createState() => _SessionTimeoutState();
}

class _SessionTimeoutState extends State<SessionTimeout> {
  Timer _timer;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      return;
    }

    _timer = Timer.periodic(
      Duration(minutes: 1),
      (Timer timer) {
        final store = StoreProvider.of<AppState>(context);
        final state = store.state;
        final sessionTimeout = state.company.sessionTimeout;
        final sessionLength = DateTime.now().millisecondsSinceEpoch -
            state.userCompanyState.lastUpdated;

        print('## Timeout: $sessionTimeout, Length: $sessionLength');
        if (sessionTimeout != 0 && sessionLength > sessionTimeout) {
          store.dispatch(UserLogout(context, navigate: false));
          WebUtils.reloadBrowser();
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
