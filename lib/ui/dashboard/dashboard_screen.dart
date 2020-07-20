import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_sidebar_selectors.dart';
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
    with TickerProviderStateMixin {
  TabController _mainTabController;
  TabController _sideTabController;
  ScrollController _scrollController;

  // TODO fix this
  static const DASHBOARD_PANEL_HEIGHT = 501;

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(vsync: this, length: 2);
    _sideTabController = TabController(vsync: this, length: 3);
    _scrollController = ScrollController();
    _scrollController.addListener(onScrollListener);
  }

  void onScrollListener() {
    final offset = _scrollController.position.pixels;
    final offsetIndex = ((offset + 120) / DASHBOARD_PANEL_HEIGHT).floor();

    if (_sideTabController.index != offsetIndex) {
      _sideTabController.index = offsetIndex;
    }
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _sideTabController.dispose();
    _scrollController.removeListener(onScrollListener);
    _scrollController.dispose();
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
                  child: _SidebarScaffold(
                    tabController: _sideTabController,
                    scrollController: _scrollController,
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

class _SidebarScaffold extends StatelessWidget {
  const _SidebarScaffold({
    @required this.tabController,
    @required this.scrollController,
  });

  final TabController tabController;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TabBar(
          isScrollable: true,
          controller: tabController,
          onTap: (int index) {
            scrollController.jumpTo((index.toDouble() *
                    _DashboardScreenState.DASHBOARD_PANEL_HEIGHT) +
                1);
          },
          tabs: [
            Tab(
              text: localization.invoices,
            ),
            Tab(
              text: localization.payments,
            ),
            Tab(
              text: localization.quotes,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          _InvoiceSidebar(),
          _PaymentSidebar(),
          _DashboardSidebar(
            label1: localization.upcomingQuotes,
            label2: localization.expiredQuotes,
          ),
        ],
      ),
    );
  }
}

class _DashboardSidebar extends StatelessWidget {
  const _DashboardSidebar({
    @required this.label1,
    this.label2,
    @required this.list1,
    this.list2,
  });

  final String label1;
  final String label2;

  final ListView list1;
  final ListView list2;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Container(
          child: Text(label1, style: textTheme.bodyText2),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        Expanded(
          child: list1,
        ),
        if (label2 != null) ...[
          Container(
            child: Text(label2, style: textTheme.bodyText2),
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          Expanded(
            child: list2 ?? Container(color: Theme.of(context).cardColor),
          ),
        ]
      ],
    );
  }
}

class _InvoiceSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final invoices = memoizedUpcomingInvoices(state.invoiceState.map);
    print('## BUILD INVOICES: ${invoices.length}');

    return _DashboardSidebar(
      label1: localization.upcomingInvoices,
      list1: ListView.builder(
        shrinkWrap: true,
        itemCount: invoices.length,
        itemBuilder: (BuildContext context, int index) {
          return Text(invoices[index].number);
        },
      ),
      label2: localization.pastDueInvoices,
    );
  }
}

class _PaymentSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('## BUILD PAYMENTS');

    return Container();
  }
}
