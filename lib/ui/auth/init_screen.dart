import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';
import 'package:redux/redux.dart';

class InitScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
        onInit: (Store<AppState> store) =>
            store.dispatch(LoadStateRequest(context)),
        builder: (BuildContext context, Store<AppState> store) {
          return Container(
            color: Colors.grey,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(),
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
