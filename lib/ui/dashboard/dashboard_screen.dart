import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_toggle_buttons.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_activity.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';
import 'package:invoiceninja_flutter/utils/formatting.dart';
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
    final offsetIndex = ((offset + 120) / 500).floor();

    if (_sideTabController.index != offsetIndex) {
      _sideTabController.index = offsetIndex;
    }

    print('## SCROLLED - Offset: $offset, ${(offset / 500).floor()}');
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
            print('## index: $index');
            scrollController.jumpTo((index.toDouble() * 500) + 1);
            /*
            scrollController.animateTo(index.toDouble() * 500,
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOutCubic);

             */
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
          _DashboardSidebar(
            label2: localization.pastDue,
          ),
          _DashboardSidebar(
            label1: localization.recent,
          ),
          _DashboardSidebar(
            label2: localization.expired,
          ),
        ],
      ),
    );
  }
}

class _DashboardSidebar extends StatelessWidget {
  const _DashboardSidebar({
    this.label1,
    this.label2,
  });

  final String label1;
  final String label2;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);

    return Column(
      children: [
        Text(label1 ?? localization.upcoming),
        Expanded(
          child: Placeholder(),
        ),
        if (label2 != null) ...[
          Text(localization.pastDue),
          Expanded(
            child: Placeholder(),
          ),
        ]
      ],
    );
  }
}
