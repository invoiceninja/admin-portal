import 'package:invoiceninja_flutter/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:invoiceninja_flutter/data/models/entities.dart';
import 'package:invoiceninja_flutter/redux/app/app_actions.dart';
import 'package:invoiceninja_flutter/redux/app/app_state.dart';
import 'package:invoiceninja_flutter/redux/client/client_actions.dart';
import 'package:invoiceninja_flutter/redux/dashboard/dashboard_actions.dart';
import 'package:invoiceninja_flutter/redux/reports/reports_actions.dart';
import 'package:invoiceninja_flutter/redux/settings/settings_actions.dart';
import 'package:invoiceninja_flutter/redux/ui/pref_state.dart';
import 'package:invoiceninja_flutter/ui/app/app_builder.dart';
import 'package:invoiceninja_flutter/ui/app/forms/app_dropdown_button.dart';
import 'package:invoiceninja_flutter/ui/app/history_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/icon_text.dart';
import 'package:invoiceninja_flutter/ui/app/menu_drawer_vm.dart';
import 'package:invoiceninja_flutter/ui/app/help_text.dart';
import 'package:invoiceninja_flutter/ui/app/screen_imports.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen.dart';
import 'package:invoiceninja_flutter/ui/credit/credit_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/edit/credit_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/credit/view/credit_view_vm.dart';
import 'package:invoiceninja_flutter/ui/design/design_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/design/edit/design_edit_vm.dart';
import 'package:invoiceninja_flutter/ui/design/view/design_view_vm.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen.dart';
import 'package:invoiceninja_flutter/ui/reports/reports_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/account_management_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/settings_screen_vm.dart';
import 'package:invoiceninja_flutter/ui/settings/tax_settings_vm.dart';
import 'package:invoiceninja_flutter/utils/localization.dart';
import 'package:invoiceninja_flutter/utils/platforms.dart';
import 'package:invoiceninja_flutter/ui/app/app_border.dart';
import 'package:redux/redux.dart';

class MainScreen extends StatelessWidget {
  static const String route = '/main';

  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
        onInit: (Store<AppState> store) => store.dispatch(LoadClients()),
        builder: (BuildContext context, Store<AppState> store) {
          final state = store.state;
          final uiState = state.uiState;
          final prefState = state.prefState;
          final subRoute = '/' + uiState.subRoute;
          String mainRoute = '/' + uiState.mainRoute;
          Widget screen = BlankScreen();

          bool isFullScreen = false;
          if (prefState.isDesktop) {
            if ([
                  InvoiceScreen.route,
                  QuoteScreen.route,
                  CreditScreen.route,
                ].contains(mainRoute) &&
                subRoute == '/edit') {
              isFullScreen = true;
            }
          }
          if (prefState.isNotMobile &&
              DesignEditScreen.route == uiState.currentRoute) {
            isFullScreen = true;
          }

          if (isFullScreen) {
            switch (mainRoute) {
              case InvoiceScreen.route:
                screen = InvoiceEditScreen();
                break;
              case QuoteScreen.route:
                screen = QuoteEditScreen();
                break;
              case CreditScreen.route:
                screen = CreditEditScreen();
                break;
              default:
                switch (uiState.currentRoute) {
                  case DesignEditScreen.route:
                    screen = DesignEditScreen();
                    break;
                }
            }
          } else {
            bool editingFilterEntity = false;
            if (uiState.filterEntityId != null && subRoute == '/edit') {
              if (mainRoute == '/${uiState.filterEntityType}') {
                mainRoute = '/' + uiState.previousMainRoute;
                editingFilterEntity = true;
              }
            }

            switch (mainRoute) {
              case DashboardScreenBuilder.route:
                screen = Row(
                  children: <Widget>[
                    Expanded(
                      child: DashboardScreenBuilder(),
                      flex: 5,
                    ),
                    if (prefState.showHistory) ...[
                      _CustomDivider(),
                      HistoryDrawerBuilder(),
                    ],
                  ],
                );
                break;
              case ClientScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.client,
                  listWidget: ClientScreenBuilder(),
                  viewWidget: ClientViewScreen(),
                  editWidget: ClientEditScreen(),
                  editingFIlterEntity: editingFilterEntity,
                );
                break;
              case ProductScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.product,
                  listWidget: ProductScreenBuilder(),
                  viewWidget: ProductViewScreen(),
                  editWidget: ProductEditScreen(),
                  editingFIlterEntity: editingFilterEntity,
                );
                break;
              case InvoiceScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.invoice,
                  listWidget: InvoiceScreenBuilder(),
                  viewWidget: InvoiceViewScreen(),
                  editWidget: InvoiceEditScreen(),
                  emailWidget: InvoiceEmailScreen(),
                  editingFIlterEntity: editingFilterEntity,
                );
                break;
              case PaymentScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.payment,
                  listWidget: PaymentScreenBuilder(),
                  viewWidget: PaymentViewScreen(),
                  editWidget: PaymentEditScreen(),
                  editingFIlterEntity: editingFilterEntity,
                );
                break;
              case QuoteScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.quote,
                  listWidget: QuoteScreenBuilder(),
                  viewWidget: QuoteViewScreen(),
                  editWidget: QuoteEditScreen(),
                  editingFIlterEntity: editingFilterEntity,
                );
                break;
              case CreditScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.credit,
                  listWidget: CreditScreenBuilder(),
                  viewWidget: CreditViewScreen(),
                  editWidget: CreditEditScreen(),
                  editingFIlterEntity: editingFilterEntity,
                );
                break;
              case ProjectScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.project,
                  listWidget: ProjectScreenBuilder(),
                  viewWidget: ProjectViewScreen(),
                  editWidget: ProjectEditScreen(),
                  editingFIlterEntity: editingFilterEntity,
                );
                break;
              case TaskScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.task,
                  listWidget: TaskScreenBuilder(),
                  viewWidget: TaskViewScreen(),
                  editWidget: TaskEditScreen(),
                  editingFIlterEntity: editingFilterEntity,
                );
                break;
              case VendorScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.vendor,
                  listWidget: VendorScreenBuilder(),
                  viewWidget: VendorViewScreen(),
                  editWidget: VendorEditScreen(),
                  editingFIlterEntity: editingFilterEntity,
                );
                break;
              case ExpenseScreen.route:
                screen = EntityScreens(
                  entityType: EntityType.expense,
                  listWidget: ExpenseScreenBuilder(),
                  viewWidget: ExpenseViewScreen(),
                  editWidget: ExpenseEditScreen(),
                  editingFIlterEntity: editingFilterEntity,
                );
                break;

              case SettingsScreen.route:
                screen = SettingsScreens();
                break;
              case ReportsScreen.route:
                screen = Row(
                  children: <Widget>[
                    Expanded(
                      child: ReportsScreenBuilder(),
                      flex: 5,
                    ),
                    if (prefState.showHistory) ...[
                      _CustomDivider(),
                      HistoryDrawerBuilder(),
                    ],
                  ],
                );
                break;
            }
          }

          return WillPopScope(
            onWillPop: () async {
              final state = store.state;
              final historyList = state.historyList;

              if (historyList.length <= 1) {
                return true;
              }

              final isEditing = state.uiState.isEditing;
              final history = historyList[isEditing ? 0 : 1];

              if (!isEditing) {
                store.dispatch(PopLastHistory());
              }

              switch (history.entityType) {
                case EntityType.dashboard:
                  store.dispatch(
                      ViewDashboard(navigator: Navigator.of(context)));
                  break;
                case EntityType.reports:
                  store.dispatch(ViewReports(navigator: Navigator.of(context)));
                  break;
                case EntityType.settings:
                  store
                      .dispatch(ViewSettings(navigator: Navigator.of(context)));
                  break;
                default:
                  viewEntityById(
                    context: context,
                    entityId: history.id,
                    entityType: history.entityType,
                    showError: false,
                  );
              }

              return false;
            },
            child: SafeArea(
              child: FocusTraversalGroup(
                policy: WidgetOrderTraversalPolicy(),
                child: ChangeLayoutBanner(
                  appLayout: prefState.appLayout,
                  child: Row(children: <Widget>[
                    if (prefState.showMenu) ...[
                      MenuDrawerBuilder(),
                      _CustomDivider(),
                    ],
                    Expanded(
                        child: AppBorder(
                      child: screen,
                      isLeft: prefState.showMenu,
                    )),
                  ]),
                ),
              ),
            ),
          );
        });
  }
}

class SettingsScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final prefState = state.prefState;

    Widget screen = BlankScreen();

    switch (uiState.subRoute) {
      case kSettingsCompanyDetails:
        screen = CompanyDetailsScreen();
        break;
      case kSettingsUserDetails:
        screen = UserDetailsScreen();
        break;
      case kSettingsLocalization:
        screen = LocalizationScreen();
        break;
      case kSettingsOnlinePayments:
        screen = CompanyGatewayScreenBuilder();
        break;
      case kSettingsOnlinePaymentsView:
        screen = CompanyGatewayViewScreen();
        break;
      case kSettingsOnlinePaymentsEdit:
        screen = CompanyGatewayEditScreen();
        break;
      case kSettingsTaxSettings:
        screen = TaxSettingsScreen();
        break;
      case kSettingsTaxRates:
        screen = TaxRateScreenBuilder();
        break;
      case kSettingsTaxRatesView:
        screen = TaxRateViewScreen();
        break;
      case kSettingsTaxRatesEdit:
        screen = TaxRateEditScreen();
        break;
      case kSettingsProducts:
        screen = ProductSettingsScreen();
        break;
      case kSettingsIntegrations:
        screen = IntegrationSettingsScreen();
        break;
      case kSettingsImportExport:
        screen = ImportExportScreen();
        break;
      case kSettingsDeviceSettings:
        screen = DeviceSettingsScreen();
        break;
      case kSettingsGroupSettings:
        screen = GroupScreenBuilder();
        break;
      case kSettingsGroupSettingsView:
        screen = GroupViewScreen();
        break;
      case kSettingsGroupSettingsEdit:
        screen = GroupEditScreen();
        break;
      case kSettingsGeneratedNumbers:
        screen = GeneratedNumbersScreen();
        break;
      case kSettingsCustomFields:
        screen = CustomFieldsScreen();
        break;
      case kSettingsWorkflowSettings:
        screen = WorkflowSettingsScreen();
        break;
      case kSettingsInvoiceDesign:
        screen = InvoiceDesignScreen();
        break;
      case kSettingsClientPortal:
        screen = ClientPortalScreen();
        break;
      case kSettingsBuyNowButtons:
        screen = BuyNowButtonsScreen();
        break;
      case kSettingsEmailSettings:
        screen = EmailSettingsScreen();
        break;
      case kSettingsTemplatesAndReminders:
        screen = TemplatesAndRemindersScreen();
        break;
      case kSettingsCreditCardsAndBanks:
        screen = CreditCardsAndBanksScreen();
        break;
      case kSettingsDataVisualizations:
        screen = DataVisualizationsScreen();
        break;
      case kSettingsUserManagement:
        screen = UserScreenBuilder();
        break;
      case kSettingsUserManagementView:
        screen = UserViewScreen();
        break;
      case kSettingsUserManagementEdit:
        screen = UserEditScreen();
        break;
      case kSettingsCustomDesigns:
        screen = DesignScreenBuilder();
        break;
      case kSettingsCustomDesignsView:
        screen = DesignViewScreen();
        break;
      case kSettingsCustomDesignsEdit:
        screen = DesignEditScreen();
        break;
      case kSettingsAccountManagement:
        screen = AccountManagementScreen();
        break;
    }

    return Row(children: <Widget>[
      Expanded(
        child: SettingsScreenBuilder(),
        flex: 2,
      ),
      _CustomDivider(),
      Expanded(
        flex: 3,
        child: AppBorder(
          child: screen,
          isLeft: true,
        ),
      ),
      if (prefState.showHistory) ...[
        _CustomDivider(),
        HistoryDrawerBuilder(),
      ],
    ]);
  }
}

class EntityScreens extends StatelessWidget {
  const EntityScreens({
    @required this.listWidget,
    @required this.editWidget,
    @required this.viewWidget,
    @required this.entityType,
    this.emailWidget,
    this.editingFIlterEntity,
  });

  final Widget listWidget;
  final Widget viewWidget;
  final Widget editWidget;
  final Widget emailWidget;
  final EntityType entityType;
  final bool editingFIlterEntity;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;
    final prefState = state.prefState;
    final subRoute = uiState.subRoute;
    final entityUIState = state.getUIState(entityType);
    final isPreviewVisible = prefState.isPreviewVisible;
    final isPreviewShown =
        isPreviewVisible || (subRoute != 'view' && subRoute.isNotEmpty);

    int listFlex = 3;
    const previewFlex = 2;

    if (prefState.isModuleTable && !isPreviewShown) {
      listFlex = 5;
    }

    Widget child;
    if (subRoute == 'email') {
      child = emailWidget;
    } else if (subRoute == 'edit' && !editingFIlterEntity) {
      child = editWidget;
    } else if ((entityUIState.selectedId ?? '').isNotEmpty &&
        state.getEntityMap(entityType).containsKey(entityUIState.selectedId)) {
      child = viewWidget;
    } else {
      child = BlankScreen(AppLocalization.of(context).noRecordSelected);
    }

    Widget leftFilterChild;
    Widget topFilterChild;

    if (prefState.fullHeightFilter) {
      if (uiState.filterEntityType != null) {
        switch (uiState.filterEntityType) {
          case EntityType.client:
            leftFilterChild = editingFIlterEntity
                ? ClientEditScreen()
                : ClientViewScreen(isFilter: true);
            break;
          case EntityType.invoice:
            leftFilterChild = editingFIlterEntity
                ? InvoiceViewScreen()
                : InvoiceViewScreen(isFilter: true);
            break;
          case EntityType.payment:
            leftFilterChild = editingFIlterEntity
                ? PaymentEditScreen()
                : PaymentViewScreen(isFilter: true);
            break;
          case EntityType.user:
            leftFilterChild = editingFIlterEntity
                ? UserEditScreen()
                : UserViewScreen(isFilter: true);
            break;
          case EntityType.group:
            leftFilterChild = editingFIlterEntity
                ? GroupEditScreen()
                : GroupViewScreen(isFilter: true);
            break;
        }
      }
    } else {
      topFilterChild = _EntityFilter(
        show: uiState.filterEntityType != null,
      );
    }

    return Row(
      children: <Widget>[
        if (leftFilterChild != null)
          Expanded(
            child: leftFilterChild,
            flex: previewFlex,
          ),
        Expanded(
          child: ClipRRect(
            child: AppBorder(
              isLeft: leftFilterChild != null,
              child: topFilterChild == null
                  ? listWidget
                  : Column(
                      children: [
                        topFilterChild,
                        Expanded(
                          child: AppBorder(
                            isTop: uiState.filterEntityType != null,
                            child: listWidget,
                          ),
                        )
                      ],
                    ),
            ),
          ),
          flex: listFlex,
        ),
        _CustomDivider(),
        if (prefState.isModuleList || isPreviewShown)
          Expanded(
            flex: previewFlex,
            child: AppBorder(
              child: child,
              isLeft: true,
            ),
          ),
        if (prefState.showHistory) ...[
          _CustomDivider(),
          AppBorder(
            child: HistoryDrawerBuilder(),
            isLeft: true,
          ),
        ],
      ],
    );
  }
}

class BlankScreen extends StatelessWidget {
  const BlankScreen([this.message]);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: isMobile(context),
        backgroundColor: Theme.of(context).cardColor,
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        child: HelpText(message ?? ''),
      ),
    );
  }
}

class _CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //VerticalDivider(width: isDarkMode(context) ? 1 : .5, color: Colors.black),
    return Container(
      width: .5,
      height: double.infinity,
      color: Colors.black38,
    );
  }
}

class ChangeLayoutBanner extends StatefulWidget {
  const ChangeLayoutBanner({
    Key key,
    @required this.child,
    @required this.appLayout,
  }) : super(key: key);

  final Widget child;
  final AppLayout appLayout;

  @override
  _ChangeLayoutBannerState createState() => _ChangeLayoutBannerState();
}

class _ChangeLayoutBannerState extends State<ChangeLayoutBanner> {
  bool _dismissedChange = false;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final localization = AppLocalization.of(context);

    final calculatedLayout = calculateLayout(context, breakOutTablet: true);
    String message;

    if (!_dismissedChange) {
      if (widget.appLayout == AppLayout.mobile &&
          calculatedLayout == AppLayout.desktop) {
        //message = localization.changeToDekstopLayout;
      } else if (widget.appLayout == AppLayout.desktop &&
          calculatedLayout == AppLayout.mobile) {
        message = localization.changeToMobileLayout;
      }
    }

    if (message == null) {
      return widget.child;
    }

    return Column(
      children: [
        Material(
          color: Colors.orange,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Expanded(
                  child: IconText(
                    icon: Icons.info_outline,
                    text: message,
                  ),
                ),
                FlatButton(
                  child: Text(localization.change.toUpperCase()),
                  onPressed: () {
                    store.dispatch(
                        UserPreferencesChanged(layout: AppLayout.mobile));
                    AppBuilder.of(context).rebuild();
                    WidgetsBinding.instance.addPostFrameCallback((duration) {
                      store.dispatch(ViewDashboard(
                          navigator: Navigator.of(context), force: true));
                    });
                  },
                ),
                FlatButton(
                  child: Text(localization.dismiss.toUpperCase()),
                  onPressed: () {
                    setState(() => _dismissedChange = true);
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: widget.child,
        )
      ],
    );
  }
}

class _EntityFilter extends StatelessWidget {
  const _EntityFilter({@required this.show});

  final bool show;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    final store = StoreProvider.of<AppState>(context);
    final state = store.state;
    final uiState = state.uiState;

    final filterEntityType = uiState.filterEntityType;
    final routeEntityType = uiState.entityTypeRoute;

    final entityMap = state.getEntityMap(filterEntityType);
    final filterEntity =
        entityMap != null ? entityMap[uiState.filterEntityId] : null;

    return Material(
      color: Theme.of(context).cardColor,
      child: AnimatedContainer(
        height: show ? kTopBottomBarHeight : 0,
        duration: Duration(milliseconds: kDefaultAnimationDuration),
        curve: Curves.easeInOutCubic,
        child: AnimatedOpacity(
          opacity: show ? 1 : 0,
          duration: Duration(milliseconds: kDefaultAnimationDuration),
          curve: Curves.easeInOutCubic,
          child: Row(
            children: filterEntity == null
                ? []
                : [
                    SizedBox(width: 4),
                    FlatButton(
                      child: Text(
                        '${localization.lookup('$filterEntityType')}  ›  ${filterEntity.listDisplayName}',
                        style: TextStyle(fontSize: 17),
                      ),
                      onPressed: () => viewEntitiesByType(
                          context: context, entityType: filterEntityType),
                    ),
                    Spacer(),
                    PopupMenuButton<EntityType>(
                      child: Row(
                        children: [
                          Text(
                            routeEntityType == filterEntityType
                                ? localization.overview
                                : '${localization.lookup(routeEntityType.plural)}',
                            style: TextStyle(fontSize: 17),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                      initialValue: routeEntityType,
                      onSelected: (EntityType value) =>
                          viewEntitiesByType(context: context, entityType: value),
                      itemBuilder: (BuildContext context) => [
                        filterEntityType,
                        ...filterEntityType.relatedTypes
                      ]
                          .where(
                              (element) => state.company.isModuleEnabled(element))
                          .map((type) => PopupMenuItem<EntityType>(
                                value: type,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: 75,
                                  ),
                                  child: Text(type == filterEntityType
                                      ? localization.overview
                                      : '${localization.lookup(type.plural)}'),
                                ),
                              ))
                          .toList(),
                    ),
                    SizedBox(width: 4),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => store.dispatch(ClearEntityFilter()),
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
