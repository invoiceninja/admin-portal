import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/ui_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

import 'app_drawer_vm.dart';

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

    return WillPopScope(
        onWillPop: () async {
          store.dispatch(ViewDashboard(context: context));
          return false;
        },
        child: Scaffold(
          drawer: isMobile(context) ? AppDrawerBuilder() : null,
          //endDrawer: isMobile(context),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: showCheckbox
                ? Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: onCheckboxChanged,
                    activeColor: Theme.of(context).accentColor,
                    value: isChecked)
                : isSettings
                    ? (isMobile(context)
                        ? IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => Navigator.pop(context),
                          )
                        : null)
                    : Builder(
                        builder: (context) => GestureDetector(
                              onLongPress: onHamburgerLongPress,
                              child: IconButton(
                                icon: Icon(Icons.menu),
                                onPressed: () {
                                  if (isMobile(context)) {
                                    Scaffold.of(context).openDrawer();
                                  } else {
                                    store.dispatch(
                                        UpdateSidebar(AppSidebar.menu));
                                  }
                                },
                              ),
                            )),
            title: appBarTitle,
            actions: [
              ...appBarActions,
              if (!showCheckbox)
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      if (isMobile(context)) {
                        Scaffold.of(context).openEndDrawer();
                      } else {
                        store.dispatch(UpdateSidebar(AppSidebar.history));
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
