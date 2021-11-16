// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';

class InitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
        onInit: (Store<AppState> store) =>
            store.dispatch(LoadStateRequest(context)),
        builder: (BuildContext context, Store<AppState> store) {
          return Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Center(child: Image.asset('assets/images/icon.png')),
                ),
                SizedBox(
                  height: 4.0,
                  child: LinearProgressIndicator(),
                )
              ],
            ),
          );
        });
  }
}
