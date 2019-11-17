import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

import 'menu_drawer_vm.dart';

class ListScaffold extends StatelessWidget {
  const ListScaffold({
    @required this.appBarTitle,
    @required this.body,
    this.appBarActions,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.isChecked,
    this.onCheckboxChanged,
    this.onHamburgerLongPress,
    this.isSettings = false,
    this.showCheckbox = false,
  });

  final Widget body;
  final AppBottomBar bottomNavigationBar;
  final FloatingActionButton floatingActionButton;
  final Widget appBarTitle;
  final List<Widget> appBarActions;
  final bool isSettings;
  final bool showCheckbox;
  final Function(bool) onCheckboxChanged;
  final Function() onHamburgerLongPress;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    Widget leadingWidget;
    if (showCheckbox) {
      leadingWidget = Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: onCheckboxChanged,
          activeColor: Theme.of(context).accentColor,
          value: isChecked);
    } else if (isSettings) {
      leadingWidget = isMobile(context)
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )
          : null;
    } else {
      leadingWidget = Builder(
        builder: (context) => GestureDetector(
          onLongPress: onHamburgerLongPress,
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              if (isMobile(context) || state.prefState.isMenuFloated) {
                Scaffold.of(context).openDrawer();
              } else {
                store.dispatch(UserSettingsChanged(sidebar: AppSidebar.menu));
              }
            },
          ),
        ),
      );
    }

    return WillPopScope(
        onWillPop: () async {
          store.dispatch(ViewDashboard(navigator: Navigator.of(context)));
          return false;
        },
        child: Scaffold(
          drawer: isMobile(context) || state.prefState.isMenuFloated
              ? MenuDrawerBuilder()
              : null,
          endDrawer: isMobile(context) || state.prefState.isHistoryFloated
              ? HistoryDrawerBuilder()
              : null,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: leadingWidget,
            title: appBarTitle,
            actions: [
              ...appBarActions,
              if (!showCheckbox &&
                  !isSettings &&
                  !state.prefState.isHistoryVisible)
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      if (isMobile(context) ||
                          state.prefState.isHistoryFloated) {
                        Scaffold.of(context).openEndDrawer();
                      } else {
                        store.dispatch(
                            UserSettingsChanged(sidebar: AppSidebar.history));
                      }
                    },
                  ),
                )
            ],
          ),
          body: body,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ));
  }
}
