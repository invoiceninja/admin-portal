import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
import 'package:redux/redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/client/client_screen.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen.dart';

class MainScreen extends StatelessWidget {
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
        onInit: (Store<AppState> store) =>
            store.dispatch(LoadDashboard()),
        builder: (BuildContext context, Store<AppState> store) {
      final route = store.state.uiState.currentRoute;
      final parts = route.split('/').where((part) => part.isNotEmpty).toList();
      final mainRoute = parts[0];

      int index = 0;
      if (mainRoute == EntityType.client.name) {
        index = 1;
      }

      return Row(
        children: <Widget>[
          AppDrawerBuilder(),
          VerticalDivider(width: 1),
          Expanded(
            child: IndexedStack(
              index: index,
              key: ValueKey(index),
              children: <Widget>[
                DashboardScreen(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ClientScreen(),
                      flex: 2,
                    ),
                    VerticalDivider(width: 1),
                    Expanded(
                      flex: 3,
                      child: IndexedStack(
                        index: 0,
                        children: <Widget>[
                          ClientViewScreen(),
                          ClientEditScreen(),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}
