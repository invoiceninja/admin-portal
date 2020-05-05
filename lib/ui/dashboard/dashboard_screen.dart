import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_activity.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    Key key,
    @required this.viewModel,
  }) : super(key: key);

  final DashboardVM viewModel;

  @override
  _DashboardScreenState createState() => new _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        drawer: isMobile(context) || state.prefState.isMenuFloated
            ? MenuDrawerBuilder()
            : null,
        endDrawer: isMobile(context) || state.prefState.isHistoryFloated
            ? HistoryDrawerBuilder()
            : null,
        appBar: AppBar(
          leading: isMobile(context) || state.prefState.isMenuFloated
              ? null
              : IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () => store
                      .dispatch(UserSettingsChanged(sidebar: AppSidebar.menu)),
                ),
          title: ListFilter(
            title: AppLocalization.of(context).dashboard,
            filter: state.uiState.filter,
            onFilterChanged: (value) {
              store.dispatch(FilterCompany(value));
            },
            filterLabel: localization.search,
          ),
          actions: [
            if (isMobile(context) || !state.prefState.isHistoryVisible)
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    if (isMobile(context) || state.prefState.isHistoryFloated) {
                      Scaffold.of(context).openEndDrawer();
                    } else {
                      store.dispatch(
                          UserSettingsChanged(sidebar: AppSidebar.history));
                    }
                  },
                ),
              ),
          ],
          bottom: TabBar(
            controller: _controller,
            tabs: [
              Tab(
                text: localization.overview,
              ),
              Tab(
                text: localization.activity,
              ),
            ],
          ),
        ),
        body: CustomTabBarView(
          viewModel: widget.viewModel,
          controller: _controller,
        ),
      ),
    );
  }
}

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({
    @required this.viewModel,
    @required this.controller,
  });

  final DashboardVM viewModel;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    if ((viewModel.filter ?? '').isNotEmpty) {
      return ListView.builder(
          itemCount: viewModel.filteredList.length,
          itemBuilder: (BuildContext context, index) {
            final localization = AppLocalization.of(context);
            final entity = viewModel.filteredList[index];
            final subtitle = entity.matchesFilterValue(viewModel.filter);

            return ListTile(
              title: Text(entity.listDisplayName),
              leading: Icon(getEntityIcon(entity.entityType)),
              trailing: Icon(Icons.navigate_next),
              subtitle: Text(subtitle != null
                  ? subtitle
                  : localization.lookup('${entity.entityType}')),
              onTap: () => viewEntity(context: context, entity: entity),
            );
          });
    }

    return TabBarView(
      controller: controller,
      children: <Widget>[
        /*
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: DashboardPanels(
            viewModel: viewModel,
          ),
        ),
        */
        DashboardPanels(
          viewModel: viewModel,
        ),
        RefreshIndicator(
            onRefresh: () => viewModel.onRefreshed(context),
            child: DashboardActivity(viewModel: viewModel)),
      ],
    );
  }
}
