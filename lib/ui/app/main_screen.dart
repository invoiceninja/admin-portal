import 'package:invoiceninja_flutter/ui/settings/settings_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/ui/client/edit/client_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/client/view/client_view_vm.dart';
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
        onInit: (Store<AppState> store) => store.dispatch(LoadDashboard()),
        builder: (BuildContext context, Store<AppState> store) {
          final uiState = store.state.uiState;
          final mainRoute = uiState.mainRoute;
          int mainIndex = 0;

          if (mainRoute == EntityType.client.name) {
            mainIndex = 1;
          } else if (mainRoute == 'settings') {
            mainIndex = 2;
          }

          return Row(
            children: <Widget>[
              if (uiState.isMenuVisible) AppDrawerBuilder(),
              if (uiState.isMenuVisible) VerticalDivider(width: 1),
              Expanded(
                child: IndexedStack(
                  index: mainIndex,
                  children: <Widget>[
                    DashboardScreen(),
                    EntityScreens(
                        listWidget: ClientScreen(),
                        viewWidget: ClientViewScreen(),
                        editWidget: ClientEditScreen()),
                    SettingsScreen(),
                  ],
                ),
              ),
            ],
          );
        });
  }
}

class EntityScreens extends StatelessWidget {
  const EntityScreens({this.listWidget, this.editWidget, this.viewWidget});

  final Widget listWidget;
  final Widget viewWidget;
  final Widget editWidget;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final uiState = store.state.uiState;
    final subRoute = store.state.uiState.subRoute;

    return Row(
      children: <Widget>[
        Expanded(
          child: listWidget,
          flex: 2,
        ),
        VerticalDivider(width: 1),
        Expanded(
          flex: 3,
          child: IndexedStack(
            index: subRoute == 'edit' ? 1 : 0,
            children: <Widget>[
              uiState.clientUIState.selectedId > 0 ? viewWidget : BlankScreen(),
              editWidget,
            ],
          ),
        ),
      ],
    );
  }
}

class BlankScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(),
    );
  }
}
