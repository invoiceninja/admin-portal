import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
// ignore: unused_import
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class MobileSessionTimeout extends StatefulWidget {
  const MobileSessionTimeout({this.child});
  final Widget child;

  @override
  _MobileSessionTimeoutState createState() => _MobileSessionTimeoutState();
}

class _MobileSessionTimeoutState extends State<MobileSessionTimeout> {
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

        if (sessionTimeout == 0 || isDesktop(context)) {
          return;
        }

        final sessionLength = DateTime.now().millisecondsSinceEpoch -
            state.userCompanyState.lastUpdated;

        if (sessionLength > sessionTimeout) {
          store.dispatch(UserLogout());
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
