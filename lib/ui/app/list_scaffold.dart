import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'menu_drawer_vm.dart';

class ListScaffold extends StatelessWidget {
  const ListScaffold({
    @required this.appBarTitle,
    @required this.body,
    @required this.entityType,
    this.onCheckboxPressed,
    this.appBarActions,
    this.appBarLeadingActions = const [],
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.onHamburgerLongPress,
    this.onCancelSettingsSection,
    this.onCancelSettingsIndex = 0,
  });

  final EntityType entityType;
  final Widget body;
  final AppBottomBar bottomNavigationBar;
  final FloatingActionButton floatingActionButton;
  final Widget appBarTitle;
  final List<Widget> appBarActions;
  final List<Widget> appBarLeadingActions;
  final Function() onHamburgerLongPress;
  final String onCancelSettingsSection;
  final int onCancelSettingsIndex;
  final Function onCheckboxPressed;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final localization = AppLocalization.of(context);
    final isSettings = entityType.isSetting;

    Widget leading = SizedBox();
    if (isSettings) {
      leading = isMobile(context)
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            )
          : IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                createEntityByType(entityType: entityType, context: context);
              },
            );
    } else if (isMobile(context) || state.prefState.isMenuFloated) {
      leading = Builder(
        builder: (context) => InkWell(
          onLongPress: onHamburgerLongPress,
          child: IconButton(
            tooltip: localization.menuSidebar,
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      );
    } else if (entityType != null && entityType != EntityType.settings) {
      leading = IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          createEntityByType(entityType: entityType, context: context);
        },
      );
    }

    leading = Row(
      children: [
        Expanded(child: leading),
        if (isDesktop(context) && onCheckboxPressed != null)
          Expanded(
              child: IconButton(
            icon: Icon(Icons.check_box),
            onPressed: () => onCheckboxPressed(),
          )),
        ...appBarLeadingActions,
      ],
    );

    return WillPopScope(
        onWillPop: () async {
          store.dispatch(ViewDashboard());
          return false;
        },
        child: Scaffold(
          drawer: isMobile(context) || state.prefState.isMenuFloated
              ? MenuDrawerBuilder()
              : null,
          endDrawer: isMobile(context) ||
                  (state.prefState.isHistoryFloated && !isSettings)
              ? HistoryDrawerBuilder()
              : null,
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            leading: leading,
            leadingWidth: kMinInteractiveDimension *
                (appBarLeadingActions.length +
                    (onCheckboxPressed == null || isMobile(context) ? 1 : 2)),
            title: appBarTitle,
            actions: [
              ...appBarActions ?? <Widget>[],
              if (isDesktop(context) && onCancelSettingsSection != null)
                TextButton(
                    onPressed: () {
                      store.dispatch(ViewSettings(
                        company: state.company,
                        section: onCancelSettingsSection,
                        tabIndex: onCancelSettingsIndex,
                      ));
                    },
                    child: Text(
                      localization.back,
                      style: TextStyle(color: state.headerTextColor),
                    )),
              if (!isSettings &&
                  (isMobile(context) || !state.prefState.isHistoryVisible))
                Builder(
                  builder: (context) => IconButton(
                    padding: const EdgeInsets.only(left: 4, right: 20),
                    tooltip: localization.history,
                    icon: Icon(Icons.history),
                    onPressed: () {
                      if (isMobile(context) ||
                          state.prefState.isHistoryFloated) {
                        Scaffold.of(context).openEndDrawer();
                      } else {
                        store.dispatch(
                            UpdateUserPreferences(sidebar: AppSidebar.history));
                      }
                    },
                  ),
                ),
            ],
          ),
          body: ClipRect(
            child: body,
          ),
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        ));
  }
}
