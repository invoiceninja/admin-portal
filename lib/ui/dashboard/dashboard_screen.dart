import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_activity.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_sidebar.dart';
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
    with TickerProviderStateMixin {
  TabController _mainTabController;
  TabController _sideTabController;
  ScrollController _scrollController;
  final List<EntityType> _tabs = [];

  @override
  void initState() {
    super.initState();

    final company = widget.viewModel.state.company;
    [
      EntityType.invoice,
      EntityType.payment,
      EntityType.quote,
    ].forEach((entityType) {
      if (company.isModuleEnabled(entityType)) {
        _tabs.add(entityType);
      }
    });

    _mainTabController = TabController(vsync: this, length: 2);
    _sideTabController = TabController(vsync: this, length: _tabs.length)
      ..addListener(onTabListener);
    _scrollController = ScrollController()..addListener(onScrollListener);
  }

  void onScrollListener() {
    final offset = _scrollController.position.pixels;
    final offsetIndex = ((offset + 120) / kDashboardPanelHeight).floor();

    if (_sideTabController.index != offsetIndex) {
      _sideTabController.index = offsetIndex;

      // This causes a bit of jank
      //widget.viewModel.onEntityTypeChanged(_tabs[offsetIndex]);
    }
  }

  void onTabListener() {
    final index = _sideTabController.index;
    _scrollController.jumpTo((index.toDouble() * kDashboardPanelHeight) + 1);
    widget.viewModel.onEntityTypeChanged(_tabs[index]);
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _sideTabController
      ..removeListener(onTabListener)
      ..dispose();
    _scrollController
      ..removeListener(onScrollListener)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;

    final mainScaffold = Scaffold(
      drawer: isMobile(context) || state.prefState.isMenuFloated
          ? MenuDrawerBuilder()
          : null,
      endDrawer: isMobile(context) || state.prefState.isHistoryFloated
          ? HistoryDrawerBuilder()
          : null,
      appBar: AppBar(
        centerTitle: false,
        leading: isMobile(context) || state.prefState.isMenuFloated
            ? null
            : SizedBox(),
        title: ListFilter(
          placeholder: localization.searchCompany,
          filter: state.uiState.filter,
          onFilterChanged: (value) {
            store.dispatch(FilterCompany(value));
          },
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
                        UserPreferencesChanged(sidebar: AppSidebar.history));
                  }
                },
              ),
            ),
        ],
        bottom: TabBar(
          controller: _mainTabController,
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
      body: _CustomTabBarView(
        viewModel: widget.viewModel,
        tabController: _mainTabController,
        scrollController: _scrollController,
      ),
    );

    return WillPopScope(
      onWillPop: () async => true,
      child: isDesktop(context)
          ? Row(
              children: [
                Flexible(
                  child: mainScaffold,
                  flex: 3,
                ),
                Flexible(
                  child: AppBorder(
                    isLeft: true,
                    child: SidebarScaffold(
                      tabController: _sideTabController,
                    ),
                  ),
                  flex: 2,
                ),
              ],
            )
          : mainScaffold,
    );
  }
}

class _CustomTabBarView extends StatelessWidget {
  const _CustomTabBarView({
    @required this.viewModel,
    @required this.tabController,
    @required this.scrollController,
  });

  final DashboardVM viewModel;
  final TabController tabController;
  final ScrollController scrollController;

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
      controller: tabController,
      children: <Widget>[
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: DashboardPanels(
            viewModel: viewModel,
            scrollController: scrollController,
          ),
        ),
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: DashboardActivity(viewModel: viewModel),
        ),
      ],
    );
  }
}
