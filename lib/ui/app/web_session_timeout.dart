// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';

// ignore: unused_import
import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';

class WebSessionTimeout extends StatefulWidget {
  const WebSessionTimeout({this.child});

  final Widget? child;

  @override
  _WebSessionTimeoutState createState() => _WebSessionTimeoutState();
}

class _WebSessionTimeoutState extends State<WebSessionTimeout> {
  Timer? _timer;

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

        if (sessionTimeout == 0) {
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
    return widget.child!;
  }
}
