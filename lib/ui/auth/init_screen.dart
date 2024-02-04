// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:redux/redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/auth/auth_actions.dart';

class InitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context)!;

    return StoreBuilder(
        onInit: (Store<AppState> store) =>
            store.dispatch(LoadStateRequest(context)),
        builder: (BuildContext context, Store<AppState> store) {
          return Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(child: SizedBox()),
                Expanded(
                  child: Center(child: Image.asset('assets/images/icon.png')),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 100,
                        child: Material(
                          child: ElevatedButton(
                            child: Text(
                              localization.logout.toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              store.dispatch(UserLogout());
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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
