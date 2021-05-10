import 'package:flutter/foundation.dart';
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
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_activity.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_sidebar.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_system_logs.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_wizard.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/utils/app_context.dart';

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

    final state = widget.viewModel.state;
    final company = state.company;
    final entityType = state.dashboardUIState.selectedEntityType;

    [
      EntityType.invoice,
      EntityType.payment,
      EntityType.quote,
      EntityType.task,
      EntityType.expense,
    ].forEach((entityType) {
      if (company.isModuleEnabled(entityType)) {
        _tabs.add(entityType);
      }
    });

    final index = _tabs.contains(entityType) ? _tabs.indexOf(entityType) : 0;
    int mainTabCount = 3;

    if (state.prefState.isMobile) {
      mainTabCount += _tabs.length;
    }

    _mainTabController = TabController(vsync: this, length: mainTabCount);
    _sideTabController =
        TabController(vsync: this, length: _tabs.length, initialIndex: index)
          ..addListener(onTabListener);
    _scrollController =
        ScrollController(initialScrollOffset: index * kDashboardPanelHeight)
          ..addListener(onScrollListener);

    if ((state.company.settings.name ?? '').isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return SettingsWizard(
                user: state.user,
              );
            });
      });
    }
  }

  void onScrollListener() {
    if (isMobile(context)) {
      return;
    }

    final offset = _scrollController.position.pixels;
    final offsetIndex = ((offset + 120) / kDashboardPanelHeight).floor();

    if (_sideTabController.index != offsetIndex && offsetIndex < _tabs.length) {
      _sideTabController.removeListener(onTabListener);
      _sideTabController.index = offsetIndex;
      _sideTabController.addListener(onTabListener);

      widget.viewModel.onEntityTypeChanged(_tabs[offsetIndex]);
    }
  }

  void onTabListener() {
    if (isMobile(context) || _mainTabController.index != 0) {
      return;
    }

    final index = _sideTabController.index;
    final offset = _scrollController.position.pixels;
    final offsetIndex = ((offset + 120) / kDashboardPanelHeight).floor();

    if (index != offsetIndex) {
      _scrollController.jumpTo((index.toDouble() * kDashboardPanelHeight) + 1);
      widget.viewModel.onEntityTypeChanged(_tabs[index]);
    }
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
    final company = state.company;
    Widget leading = SizedBox();

    if (isMobile(context) || state.prefState.isMenuFloated) {
      leading = Builder(
        builder: (context) => InkWell(
          child: IconButton(
            tooltip: localization.menuSidebar,
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      );
    }

    final mainScaffold = Scaffold(
      drawer: isMobile(context) || state.prefState.isMenuFloated
          ? MenuDrawerBuilder()
          : null,
      endDrawer: isMobile(context) || state.prefState.isHistoryFloated
          ? HistoryDrawerBuilder()
          : null,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: leading,
        title: ListFilter(
          key: ValueKey('__cleared_at_${state.uiState.filterClearedAt}__'),
          entityType: EntityType.dashboard,
          entityIds: [],
          filter: state.uiState.filter,
          onFilterChanged: (value) {
            store.dispatch(FilterCompany(value));
          },
        ),
        actions: [
          if (isMobile(context) || !state.prefState.isHistoryVisible)
            Builder(
              builder: (context) => IconButton(
                padding: const EdgeInsets.only(left: 4, right: 20),
                tooltip: localization.history,
                icon: Icon(Icons.history),
                onPressed: () {
                  if (isMobile(context) || state.prefState.isHistoryFloated) {
                    Scaffold.of(context).openEndDrawer();
                  } else {
                    store.dispatch(
                        UpdateUserPreferences(sidebar: AppSidebar.history));
                  }
                },
              ),
            ),
        ],
        bottom: TabBar(
          controller: _mainTabController,
          isScrollable: isMobile(context),
          tabs: [
            Tab(
              text: localization.overview,
            ),
            Tab(
              text: localization.activity,
            ),
            Tab(
              text: localization.systemLogs,
            ),
            if (isMobile(context) &&
                company.isModuleEnabled(EntityType.invoice))
              Tab(
                text: localization.invoices,
              ),
            if (isMobile(context) &&
                company.isModuleEnabled(EntityType.payment))
              Tab(
                text: localization.payments,
              ),
            if (isMobile(context) && company.isModuleEnabled(EntityType.quote))
              Tab(
                text: localization.quotes,
              ),
            if (isMobile(context) && company.isModuleEnabled(EntityType.task))
              Tab(
                text: localization.tasks,
              ),
            if (isMobile(context) &&
                company.isModuleEnabled(EntityType.expense))
              Tab(
                text: localization.expense,
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
                if (state.dashboardUIState.showSidebar)
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
    final company = viewModel.state.company;

    if ((viewModel.filter ?? '').isNotEmpty) {
      return ScrollableListViewBuilder(
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
              onTap: () => viewEntity(
                  appContext: context.getAppContext(), entity: entity),
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
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: DashboardSystemLogs(viewModel: viewModel),
        ),
        if (isMobile(context) && company.isModuleEnabled(EntityType.invoice))
          InvoiceSidebar(),
        if (isMobile(context) && company.isModuleEnabled(EntityType.payment))
          PaymentSidebar(),
        if (isMobile(context) && company.isModuleEnabled(EntityType.quote))
          QuoteSidebar(),
        if (isMobile(context) && company.isModuleEnabled(EntityType.task))
          TaskSidebar(),
        if (isMobile(context) && company.isModuleEnabled(EntityType.expense))
          ExpenseSidbar(),
      ],
    );
  }
}
