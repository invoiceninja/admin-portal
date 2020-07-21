import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_sidebar_selectors.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/lists/list_divider.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_activity.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/invoice/invoice_list_item.dart';
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
                  child: AppBorder(
                    isLeft: true,
                    child: _SidebarScaffold(
                      tabController: _sideTabController,
                      scrollController: _scrollController,
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
          _QuoteSidebar(),
        ],
      ),
    );
  }
}

class _InvoiceSidebar extends StatelessWidget {
  const _InvoiceSidebar();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final upcomingInvoices = memoizedUpcomingInvoices(state.invoiceState.map);
    final pastDueInvoices = memoizedPastDueInvoices(state.invoiceState.map);
    final selectedIds = state.uiState.selectedEntities[EntityType.invoice];

    return _DashboardSidebar(
      entityType: EntityType.invoice,
      label1: localization.upcomingInvoices,
      list1: upcomingInvoices.isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              itemCount: upcomingInvoices.length,
              itemBuilder: (BuildContext context, int index) {
                return InvoiceListItem(
                  invoice: upcomingInvoices[index],
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label2: localization.pastDueInvoices,
      list2: pastDueInvoices.isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              itemCount: pastDueInvoices.length,
              itemBuilder: (BuildContext context, int index) {
                return InvoiceListItem(
                  invoice: pastDueInvoices[index],
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
      label3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : localization.selectedInvoices,
      list3: (selectedIds ?? <String>[]).isEmpty
          ? null
          : ListView.separated(
              shrinkWrap: true,
              itemCount: selectedIds?.length,
              itemBuilder: (BuildContext context, int index) {
                return InvoiceListItem(
                  invoice: state.invoiceState.get(selectedIds[index]),
                  showCheckbox: false,
                );
              },
              separatorBuilder: (context, index) => ListDivider(),
            ),
    );
  }
}

class _PaymentSidebar extends StatelessWidget {
  const _PaymentSidebar();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _QuoteSidebar extends StatelessWidget {
  const _QuoteSidebar();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _DashboardSidebar extends StatelessWidget {
  const _DashboardSidebar({
    @required this.entityType,
    @required this.label1,
    @required this.list1,
    this.label2,
    this.list2,
    this.label3,
    this.list3,
  });

  final EntityType entityType;
  final String label1;
  final String label2;
  final String label3;
  final ListView list1;
  final ListView list2;
  final ListView list3;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final textTheme = Theme.of(context).textTheme;
    final store = StoreProvider.of<AppState>(context);

    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            elevation: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Container(
              child: Text(label1, style: textTheme.bodyText2),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: double.infinity,
            ),
          ),
          Expanded(
            child:
                list1 == null ? HelpText(localization.noRecordsFound) : list1,
          ),
          if (label2 != null) ...[
            Material(
              elevation: 4,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                child: Text(label2, style: textTheme.bodyText2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                width: double.infinity,
              ),
            ),
            Expanded(
              child:
                  list2 == null ? HelpText(localization.noRecordsFound) : list2,
            ),
          ],
          AnimatedContainer(
            height: label3 == null
                ? 0
                : (MediaQuery.of(context).size.height - 100) / 2,
            duration: Duration(milliseconds: kDefaultAnimationDuration),
            curve: Curves.easeInOutCubic,
            child: AppBorder(
              isTop: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 4,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(label3 ?? '',
                                  style: textTheme.bodyText2)),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              store.dispatch(UpdateDashboardSelection(
                                entityIds: null,
                                entityType: entityType,
                              ));
                            },
                          )
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      width: double.infinity,
                    ),
                  ),
                  Expanded(
                    child: list3 ?? SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
