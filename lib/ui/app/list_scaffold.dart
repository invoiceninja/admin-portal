// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_bottom_bar.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'menu_drawer_vm.dart';

class ListScaffold extends StatelessWidget {
  const ListScaffold({
    required this.appBarTitle,
    required this.body,
    required this.entityType,
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
  final AppBottomBar? bottomNavigationBar;
  final FloatingActionButton? floatingActionButton;
  final Widget appBarTitle;
  final List<Widget>? appBarActions;
  final List<Widget> appBarLeadingActions;
  final Function? onHamburgerLongPress;
  final String? onCancelSettingsSection;
  final int onCancelSettingsIndex;
  final Function? onCheckboxPressed;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final prefState = state.prefState;
    final localization = AppLocalization.of(context);
    final isSettings = entityType.isSetting;

    Widget leading = SizedBox();
    if (isSettings && isMobile(context)) {
      leading = IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      );
    } else if (isMobile(context) || state.prefState.isMenuFloated) {
      leading = Builder(
        builder: (context) => InkWell(
          onLongPress: onHamburgerLongPress as void Function()?,
          child: IconButton(
            tooltip: localization!.menuSidebar,
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      );
    } else if (!entityType.hideCreate &&
        state.userCompany.canCreate(entityType)) {
      leading = Padding(
        padding: const EdgeInsets.only(left: 16, right: 14),
        child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  state.prefState.colorThemeModel!.colorSuccess)),
          onPressed: () {
            createEntityByType(entityType: entityType, context: context);
          },
          child: IconText(
            text: localization!.create,
            icon: Icons.add,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    double leadingWidth = 0;
    if (entityType == EntityType.settings) {
      leadingWidth = isDesktop(context) && !state.prefState.isMenuFloated
          ? 0
          : kMinInteractiveDimension;
    } else if (entityType == EntityType.document) {
      leadingWidth = kMinInteractiveDimension;
    } else {
      leadingWidth = (isDesktop(context) ? 100 : 10) +
          (kMinInteractiveDimension - 4) *
              (appBarLeadingActions.length +
                  (onCheckboxPressed == null || isMobile(context) ? 1 : 2));
    }

    leading = Row(
      children: [
        Expanded(child: leading),
        if (isDesktop(context) && onCheckboxPressed != null)
          IconButton(
            icon: Icon(Icons.check_box),
            tooltip:
                prefState.enableTooltips ? localization!.multiselect : null,
            onPressed: state.prefState.showKanban &&
                    state.uiState.mainRoute == '${EntityType.task}'
                ? null
                : () => onCheckboxPressed!(),
          ),
        if (appBarLeadingActions.isNotEmpty) SizedBox(width: 4),
        ...appBarLeadingActions,
      ],
    );

    return PopScope(
        canPop: !isSettings,
        onPopInvoked: (_) {
          if (!isSettings) {
            store.dispatch(ViewDashboard());
          }
        },
        child: FocusTraversalGroup(
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
              leadingWidth: leadingWidth,
              title: Row(
                children: [
                  Expanded(child: appBarTitle),
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
                          localization!.back,
                          style: TextStyle(color: state.headerTextColor),
                        )),
                ],
              ),
              actions: [
                ...appBarActions ?? <Widget>[],
                if (!isSettings &&
                    (isMobile(context) || !state.prefState.isHistoryVisible))
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconButton(
                          padding: const EdgeInsets.only(right: 8),
                          onPressed: () {
                            if (isMobile(context) ||
                                state.prefState.isHistoryFloated) {
                              Scaffold.of(context).openEndDrawer();
                            } else {
                              store.dispatch(UpdateUserPreferences(
                                  sidebar: AppSidebar.history));
                            }
                          },
                          icon: Icon(
                            Icons.history,
                            color: state.headerTextColor,
                          )),
                    );
                  })
                /*
                  Builder(
                    builder: (context) => IconButton(
                      padding: const EdgeInsets.only(left: 4, right: 20),
                      tooltip: prefState.enableTooltips
                          ? localization.history
                          : null,
                      icon: Icon(Icons.history),
                      onPressed: () {
                        if (isMobile(context) ||
                            state.prefState.isHistoryFloated) {
                          Scaffold.of(context).openEndDrawer();
                        } else {
                          store.dispatch(UpdateUserPreferences(
                              sidebar: AppSidebar.history));
                        }
                      },
                    ),
                  ),
                  */
              ],
            ),
            body: ClipRect(
              child: body,
            ),
            bottomNavigationBar: bottomNavigationBar,
            floatingActionButton: floatingActionButton,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
          ),
        ));
  }
}
