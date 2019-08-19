import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_drawer_vm.dart';

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
          } else if (mainRoute == EntityType.product.name) {
            mainIndex = 2;
          } else if (mainRoute == EntityType.invoice.name) {
            mainIndex = 3;
          } else if (mainRoute == EntityType.payment.name) {
            mainIndex = 4;
          } else if (mainRoute == 'settings') {
            mainIndex = 5;
          }

          return Row(
            children: <Widget>[
              if (uiState.isMenuVisible) AppDrawerBuilder(),
              if (uiState.isMenuVisible)
                VerticalDivider(width: isDarkMode(context) ? 1 : .5),
              Expanded(
                child: IndexedStack(
                  index: mainIndex,
                  children: <Widget>[
                    DashboardScreen(),
                    EntityScreens(
                        listWidget: ClientScreen(),
                        viewWidget: ClientViewScreen(),
                        editWidget: ClientEditScreen()),
                    EntityScreens(
                      listWidget: ProductScreen(),
                      viewWidget: ProductViewScreen(),
                      editWidget: ProductEditScreen(),
                    ),
                    EntityScreens(
                      listWidget: InvoiceScreen(),
                      viewWidget: InvoiceViewScreen(),
                      editWidget: InvoiceEditScreen(),
                    ),
                    EntityScreens(
                      listWidget: PaymentScreen(),
                      viewWidget: PaymentViewScreen(),
                      editWidget: PaymentEditScreen(),
                    ),
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
        VerticalDivider(width: isDarkMode(context) ? 1 : .5),
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
      body: Container(
        child: Center(
          child: Text(
            AppLocalization.of(context).noneSelected.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
