// Flutter imports:
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/constants.dart';

// Project imports:
import 'package:invoiceninja_flutter/data/models/account_model.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/data/models/serializers.dart';
import 'package:invoiceninja_flutter/data/web_client.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/list_filter.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/scrollable_listview.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_activity.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_panels.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_sidebar.dart';
import 'package:invoiceninja_flutter/ui/dashboard/dashboard_system_logs.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_wizard.dart';
import 'package:invoiceninja_flutter/utils/dialogs.dart';
import 'package:invoiceninja_flutter/utils/icons.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:invoiceninja_flutter/utils/web_stub.dart'
    if (dart.library.html) 'package:invoiceninja_flutter/utils/web.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final DashboardVM viewModel;

  @override
  _DashboardScreenState createState() => new _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late TabController _mainTabController;
  late TabController _sideTabController;
  late ScrollController _scrollController;
  final List<EntityType> _tabs = [];

  @override
  void initState() {
    super.initState();

    final state = widget.viewModel.state;
    final company = state.company;
    //final entityType = state.dashboardUIState.selectedEntityType;

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

    //final index = _tabs.contains(entityType) ? _tabs.indexOf(entityType) : 0;
    int mainTabCount = 3;

    if (state.prefState.isMobile) {
      mainTabCount += _tabs.length;
    }

    _mainTabController = TabController(vsync: this, length: mainTabCount);
    _sideTabController =
        TabController(vsync: this, length: _tabs.length, initialIndex: 0)
          ..addListener(onTabListener);
    _scrollController = ScrollController(
        // initialScrollOffset: (index > 0 ? index + 1 : 0) *
        // (kIsWeb ? kDashboardPanelHeightWeb : kDashboardPanelHeight)
        )
      ..addListener(onScrollListener);

    final companyName = state.company.settings.name ?? '';
    if (!state.isDemo &&
        state.userCompany.isAdmin &&
        (companyName.isEmpty || companyName == 'Untitled Company') &&
        state.company.isOld) {
      WidgetsBinding.instance.addPostFrameCallback((duration) {
        showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return SettingsWizard(
                user: state.user,
                company: state.company,
              );
            });
      });
    }
  }

  void onScrollListener() {
    if (isMobile(context)) {
      return;
    }

    /*
    final offset = _scrollController.position.pixels;
    int offsetIndex = ((offset + 120) /
            (kIsWeb ? kDashboardPanelHeightWeb : kDashboardPanelHeight))
        .floor();

    if (offsetIndex > 0) {
      offsetIndex--;
    }

    if (_sideTabController.index != offsetIndex && offsetIndex < _tabs.length) {
      _sideTabController.removeListener(onTabListener);
      _sideTabController.index = offsetIndex;
      _sideTabController.addListener(onTabListener);

      widget.viewModel.onEntityTypeChanged(_tabs[offsetIndex]);
    }
    */
  }

  void onTabListener() {
    /*
    if (isMobile(context) || _mainTabController.index != 0) {
      return;
    }

    final index = _sideTabController.index;
    final offset = _scrollController.position.pixels;
    final offsetIndex = ((offset + 120) /
            (kIsWeb ? kDashboardPanelHeightWeb : kDashboardPanelHeight))
        .floor();

    if (index != offsetIndex) {
      _scrollController.jumpTo((index.toDouble() *
              (kIsWeb ? kDashboardPanelHeightWeb : kDashboardPanelHeight)) +
          1);
      widget.viewModel.onEntityTypeChanged(_tabs[index]);
    }
    */
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
    Widget? leading;

    if (isMobile(context) || state.prefState.isMenuFloated) {
      leading = Builder(
        builder: (context) => InkWell(
          child: IconButton(
            tooltip: localization!.menuSidebar,
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
        title: Row(
          children: [
            if (isDesktop(context))
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: TabBar(
                    controller: _mainTabController,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        text: localization!.overview,
                      ),
                      Tab(
                        text: localization.activity,
                      ),
                      Tab(
                        text: localization.systemLogs,
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(
              flex: 2,
              child: ListFilter(
                key:
                    ValueKey('__cleared_at_${state.uiState.filterClearedAt}__'),
                entityType: EntityType.dashboard,
                entityIds: [],
                filter: state.uiState.filter,
                onFilterChanged: (value) {
                  store.dispatch(FilterCompany(value));
                },
              ),
            ),
          ],
        ),
        actions: [
          if (state.userCompany.isOwner &&
              state.isSelfHosted &&
              !state.isDemo &&
              !isPaidAccount(context) &&
              !isApple())
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  tooltip: state.prefState.enableTooltips
                      ? localization!.upgrade
                      : null,
                  onPressed: () => launchUrl(Uri.parse(kWhiteLabelUrl)),
                  icon: Icon(Icons.rocket_launch)),
            ),
          if (!kReleaseMode ||
              (kIsWeb &&
                  (state.isHosted ||
                      (state.isSelfHosted && state.userCompany.isAdmin))))
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                tooltip: localization!.enableReactApp,
                onPressed: () async {
                  if (state.isDemo) {
                    launchUrl(Uri.parse(kReactDemoUrl));
                  } else if (state.isHosted) {
                    launchUrl(Uri.parse(kAppReactUrl));
                  } else {
                    confirmCallback(
                        context: context,
                        message: localization.enableReactApp,
                        callback: (_) {
                          final credentials = state.credentials;
                          final account = state.account
                              .rebuild((b) => b..setReactAsDefaultAP = true);
                          final url =
                              '${credentials.url}/accounts/${account.id}';
                          final data = serializers.serializeWith(
                              AccountEntity.serializer, account);

                          store.dispatch(StartSaving());
                          WebClient()
                              .put(
                            url,
                            credentials.token,
                            data: json.encode(data),
                          )
                              .then((dynamic _) {
                            store.dispatch(StopSaving());
                            WebUtils.reloadBrowser();
                          }).catchError((Object error) {
                            store.dispatch(StopSaving());
                            showErrorDialog(message: error as String?);
                          });
                        });
                  }
                },
                icon: Icon(MdiIcons.react),
              ),
            ),
          if (isMobile(context) || !state.prefState.isHistoryVisible)
            Builder(
              builder: (context) => IconButton(
                padding: const EdgeInsets.only(left: 4, right: 24),
                tooltip: state.prefState.enableTooltips
                    ? localization!.history
                    : null,
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
        bottom: isMobile(context)
            ? TabBar(
                controller: _mainTabController,
                isScrollable: isMobile(context),
                tabs: [
                  Tab(
                    text: localization!.overview,
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
                  if (isMobile(context) &&
                      company.isModuleEnabled(EntityType.quote))
                    Tab(
                      text: localization.quotes,
                    ),
                  if (isMobile(context) &&
                      company.isModuleEnabled(EntityType.task))
                    Tab(
                      text: localization.tasks,
                    ),
                  if (isMobile(context) &&
                      company.isModuleEnabled(EntityType.expense))
                    Tab(
                      text: localization.expense,
                    ),
                ],
              )
            : null,
      ),
      body: _CustomTabBarView(
        viewModel: widget.viewModel,
        mainTabController: _mainTabController,
        sideTabController: _sideTabController,
        scrollController: _scrollController,
      ),
    );

    return isDesktop(context)
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
        : mainScaffold;
  }
}

class _CustomTabBarView extends StatelessWidget {
  const _CustomTabBarView({
    required this.viewModel,
    required this.mainTabController,
    required this.sideTabController,
    required this.scrollController,
  });

  final DashboardVM viewModel;
  final TabController? mainTabController;
  final TabController? sideTabController;
  final ScrollController? scrollController;

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
                  : localization!.lookup('${entity.entityType}')),
              onTap: () => viewEntity(entity: entity),
            );
          });
    }

    return TabBarView(
      controller: mainTabController,
      children: <Widget>[
        RefreshIndicator(
          onRefresh: () => viewModel.onRefreshed(context),
          child: DashboardPanels(
            viewModel: viewModel,
            scrollController: scrollController,
            tabController: sideTabController,
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
