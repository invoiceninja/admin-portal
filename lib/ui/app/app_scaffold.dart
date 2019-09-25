import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

import 'app_drawer_vm.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold(
      {@required this.appBarTitle,
      @required this.body,
      this.appBarActions,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.hideHamburgerButton = false});

  final Widget body;
  final AppBottomBar bottomNavigationBar;
  final FloatingActionButton floatingActionButton;
  final Widget appBarTitle;
  final List<Widget> appBarActions;
  final bool hideHamburgerButton;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return WillPopScope(
        onWillPop: () async {
          store.dispatch(ViewDashboard(context: context));
          return false;
        },
        child: Scaffold(
          key: scaffoldKey,
          drawer: isMobile(context) ? AppDrawerBuilder() : null,
          appBar: AppBar(
            leading: !isMobile(context) && !hideHamburgerButton
                ? IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () =>
                        store.dispatch(UpdateSidebar(AppSidebar.menu)),
                  )
                : null,
            title: appBarTitle,
            actions: appBarActions,
          ),
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ));
  }
}
